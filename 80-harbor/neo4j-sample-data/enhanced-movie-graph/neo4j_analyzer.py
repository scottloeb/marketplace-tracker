#!/usr/bin/env python3
"""
Neo4j Driver Statement Analyzer

This script analyzes Python code that uses the Neo4j driver to detect 
potential issues with executing multiple Cypher statements in a single call.

Usage:
    python neo4j_analyzer.py path/to/your/script.py
"""

import sys
import os
import ast
import re
from typing import List, Dict, Set, Tuple, Optional
import astunparse  # You may need to install this: pip install astunparse

class Neo4jDriverAnalyzer:
    """
    Analyzes Python code to detect potential Neo4j driver statement execution issues.
    """
    
    def __init__(self, filepath):
        """Initialize with the path to the file to analyze."""
        self.filepath = filepath
        self.tree = None
        self.issues = []
        self.session_run_calls = []
        self.statement_splitting_funcs = []
        self.potential_cypher_vars = set()
        
        # Patterns that might indicate Cypher statements
        self.cypher_patterns = [
            r'CREATE\s+\(',
            r'MATCH\s+\(',
            r'MERGE\s+\(',
            r'DELETE\s+',
            r'REMOVE\s+',
            r'SET\s+',
            r'WHERE\s+',
            r'RETURN\s+',
            r'WITH\s+',
            r'UNWIND\s+'
        ]
    
    def analyze(self):
        """Main analysis method."""
        try:
            # Parse the Python file
            with open(self.filepath, 'r', encoding='utf-8') as f:
                file_content = f.read()
                self.tree = ast.parse(file_content)
            
            # Run different analysis passes
            self._find_session_run_calls()
            self._find_statement_splitting_functions()
            self._find_potential_cypher_vars()
            self._analyze_run_calls()
            self._analyze_splitting_logic()
            self._analyze_string_concatenation()
            
            return self.issues
            
        except Exception as e:
            self.issues.append({
                'type': 'error',
                'message': f"Error analyzing file: {str(e)}",
                'lineno': None,
                'severity': 'high'
            })
            return self.issues
    
    def _find_session_run_calls(self):
        """Find all calls to session.run() in the code."""
        class SessionRunVisitor(ast.NodeVisitor):
            def __init__(self):
                self.run_calls = []
            
            def visit_Call(self, node):
                # Look for patterns like session.run(), driver.session().run(), etc.
                if isinstance(node.func, ast.Attribute) and node.func.attr == 'run':
                    if hasattr(node.func.value, 'id') and node.func.value.id == 'session':
                        self.run_calls.append(node)
                    elif isinstance(node.func.value, ast.Attribute) and node.func.value.attr == 'session':
                        self.run_calls.append(node)
                self.generic_visit(node)
        
        visitor = SessionRunVisitor()
        visitor.visit(self.tree)
        self.session_run_calls = visitor.run_calls
    
    def _find_statement_splitting_functions(self):
        """Find functions that might be used to split Cypher statements."""
        class StatementSplitterVisitor(ast.NodeVisitor):
            def __init__(self):
                self.splitter_funcs = []
            
            def visit_FunctionDef(self, node):
                # Look for function names or docstrings that suggest statement splitting
                if any(kw in node.name.lower() for kw in ['split', 'statement', 'query', 'cql']):
                    self.splitter_funcs.append(node)
                
                # Check if docstring mentions statement splitting
                if (node.body and isinstance(node.body[0], ast.Expr) and 
                    isinstance(node.body[0].value, ast.Str) and
                    any(kw in node.body[0].value.s.lower() for kw in 
                        ['split', 'statement', 'semicolon', 'query', 'cql'])):
                    self.splitter_funcs.append(node)
                
                self.generic_visit(node)
        
        visitor = StatementSplitterVisitor()
        visitor.visit(self.tree)
        self.statement_splitting_funcs = visitor.splitter_funcs
    
    def _find_potential_cypher_vars(self):
        """Find variables that might contain Cypher statements."""
        class CypherVarVisitor(ast.NodeVisitor):
            def __init__(self, cypher_patterns):
                self.cypher_vars = set()
                self.cypher_patterns = cypher_patterns
                self.current_assignments = {}
            
            def visit_Assign(self, node):
                # Check if value looks like it might contain Cypher
                if isinstance(node.value, ast.Str):
                    for pattern in self.cypher_patterns:
                        if re.search(pattern, node.value.s, re.IGNORECASE):
                            for target in node.targets:
                                if isinstance(target, ast.Name):
                                    self.cypher_vars.add(target.id)
                                    self.current_assignments[target.id] = node.value.s
                
                # Variable names that suggest they contain Cypher
                for target in node.targets:
                    if isinstance(target, ast.Name):
                        name = target.id.lower()
                        if any(kw in name for kw in ['cypher', 'query', 'cql', 'statement']):
                            self.cypher_vars.add(target.id)
                
                self.generic_visit(node)
        
        visitor = CypherVarVisitor(self.cypher_patterns)
        visitor.visit(self.tree)
        self.potential_cypher_vars = visitor.cypher_vars
    
    def _analyze_run_calls(self):
        """Analyze session.run() calls for potential issues."""
        for call in self.session_run_calls:
            if not call.args:
                continue
            
            first_arg = call.args[0]
            lineno = getattr(call, 'lineno', 'unknown')
            
            # Check if using a variable
            if isinstance(first_arg, ast.Name):
                var_name = first_arg.id
                if var_name in self.potential_cypher_vars:
                    self.issues.append({
                        'type': 'potential_multi_statement',
                        'message': f"Potential multi-statement query passed to session.run() using variable '{var_name}'",
                        'lineno': lineno,
                        'severity': 'medium'
                    })
            
            # Check if using a literal string
            elif isinstance(first_arg, ast.Str):
                query = first_arg.s
                if ';' in query:
                    # Count non-commented semicolons
                    stripped_query = self._strip_comments(query)
                    semicolon_count = stripped_query.count(';')
                    if semicolon_count > 0:
                        self.issues.append({
                            'type': 'multi_statement',
                            'message': f"Multiple statements (found {semicolon_count} semicolons) passed to session.run()",
                            'lineno': lineno,
                            'severity': 'high',
                            'query': query
                        })
    
    def _analyze_splitting_logic(self):
        """Analyze statement splitting functions for potential issues."""
        for func in self.statement_splitting_funcs:
            # Extract the function body as source code
            func_source = astunparse.unparse(func)
            
            # Look for common issues in splitting logic
            issues_found = []
            
            # Issue 1: Not handling escaped semicolons properly
            if ";\'" not in func_source and ';\"' not in func_source:
                issues_found.append("May not handle semicolons inside string literals properly")
            
            # Issue 2: Not handling commented semicolons
            if ";" in func_source and not re.search(r'(//|#|--)\s*;', func_source):
                issues_found.append("May not handle semicolons in comments properly")
            
            # Issue 3: Not tracking string delimiters
            if "string" in func_source.lower() and not re.search(r"['\"](.*?)['\"]", func_source):
                issues_found.append("May not properly track string delimiters")
            
            if issues_found:
                self.issues.append({
                    'type': 'splitting_logic',
                    'message': f"Statement splitting function '{func.name}' may have issues: {', '.join(issues_found)}",
                    'lineno': func.lineno,
                    'severity': 'medium',
                    'function': func.name
                })
    
    def _analyze_string_concatenation(self):
        """Analyze string concatenation that might create multi-statement queries."""
        class StringConcatVisitor(ast.NodeVisitor):
            def __init__(self, analyzer):
                self.analyzer = analyzer
            
            def visit_BinOp(self, node):
                # Look for string concatenation operations
                if isinstance(node.op, ast.Add):
                    # Check if both sides are strings or look like Cypher fragments
                    left_is_cypher = self._is_potential_cypher(node.left)
                    right_is_cypher = self._is_potential_cypher(node.right)
                    
                    if left_is_cypher and right_is_cypher:
                        self.analyzer.issues.append({
                            'type': 'string_concat',
                            'message': "String concatenation might be creating multi-statement queries",
                            'lineno': node.lineno,
                            'severity': 'medium'
                        })
                
                self.generic_visit(node)
            
            def _is_potential_cypher(self, node):
                # Check if a node might represent Cypher code
                if isinstance(node, ast.Str):
                    for pattern in self.analyzer.cypher_patterns:
                        if re.search(pattern, node.s, re.IGNORECASE):
                            return True
                elif isinstance(node, ast.Name) and node.id in self.analyzer.potential_cypher_vars:
                    return True
                return False
        
        visitor = StringConcatVisitor(self)
        visitor.visit(self.tree)
    
    def _strip_comments(self, query):
        """Remove comments from a Cypher query to avoid counting semicolons in comments."""
        # Remove line comments (// ...)
        query = re.sub(r'//.*$', '', query, flags=re.MULTILINE)
        
        # Remove block comments (/* ... */)
        query = re.sub(r'/\*.*?\*/', '', query, flags=re.DOTALL)
        
        return query
    
    def print_report(self):
        """Print a human-readable report of the issues found."""
        if not self.issues:
            print(f"✅ No Neo4j driver statement issues found in {self.filepath}")
            return
        
        print(f"⚠️ Found {len(self.issues)} potential Neo4j driver statement issues in {self.filepath}:")
        print("-" * 80)
        
        for i, issue in enumerate(self.issues, 1):
            severity_markers = {
                'high': '🔴 HIGH',
                'medium': '🟠 MEDIUM',
                'low': '🟡 LOW'
            }
            severity = severity_markers.get(issue.get('severity', 'medium'), '⚪ UNKNOWN')
            
            print(f"{i}. {severity} : {issue['message']}")
            if issue.get('lineno'):
                print(f"   Line {issue['lineno']}")
            
            if issue.get('query'):
                print(f"   Query snippet: {issue['query'][:100]}...")
            
            if issue.get('function'):
                print(f"   In function: {issue['function']}")
            
            print()
        
        print("-" * 80)
        print("🔍 Recommendations:")
        print("1. Ensure each session.run() call executes only one Cypher statement")
        print("2. Use proper statement splitting logic before execution")
        print("3. Check for semicolons in your Cypher queries")
        print("4. Review your statement splitting functions to handle edge cases properly")


def analyze_file(filepath):
    """Analyze a single Python file for Neo4j driver statement issues."""
    analyzer = Neo4jDriverAnalyzer(filepath)
    analyzer.analyze()
    analyzer.print_report()
    return analyzer.issues


def analyze_directory(directory):
    """Recursively analyze all Python files in a directory."""
    issues_by_file = {}
    
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.py'):
                filepath = os.path.join(root, file)
                issues = analyze_file(filepath)
                if issues:
                    issues_by_file[filepath] = issues
    
    return issues_by_file


def analyze_neo4j_ingestor(ingestor_path=None):
    """
    Specifically analyze the Neo4jIngestor implementation 
    for statement handling issues
    """
    if not ingestor_path:
        print("Looking for Neo4jIngestor in current directory...")
        for file in os.listdir('.'):
            if file.endswith('.py'):
                with open(file, 'r', encoding='utf-8') as f:
                    content = f.read()
                    if 'Neo4jIngestor' in content:
                        ingestor_path = file
                        break
    
    if not ingestor_path:
        print("❌ Could not find Neo4jIngestor implementation")
        return
    
    print(f"Analyzing Neo4jIngestor in {ingestor_path}...")
    issues = analyze_file(ingestor_path)
    
    if issues:
        # Additional Neo4jIngestor specific checks
        split_func_found = any(issue.get('function', '').endswith('_split_cql_statements') 
                              for issue in issues)
        
        if not split_func_found:
            print("\n⚠️ Additional Neo4jIngestor specific recommendations:")
            print("1. Check if your _split_cql_statements method correctly handles all Cypher statement edge cases")
            print("2. Ensure each statement is properly trimmed and non-empty before execution")
            print("3. Verify that execute_cql_file properly runs statements one by one")
            print("4. Consider adding validation for semicolons in your statement splitting logic")
    
    return issues


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage:")
        print("  python neo4j_analyzer.py path/to/your/script.py")
        print("  python neo4j_analyzer.py --directory path/to/directory")
        print("  python neo4j_analyzer.py --ingestor path/to/neo4j_ingestor.py")
        sys.exit(1)
    
    if sys.argv[1] == "--directory":
        if len(sys.argv) < 3:
            print("Please provide a directory path")
            sys.exit(1)
        analyze_directory(sys.argv[2])
    elif sys.argv[1] == "--ingestor":
        ingestor_path = sys.argv[2] if len(sys.argv) > 2 else None
        analyze_neo4j_ingestor(ingestor_path)
    else:
        analyze_file(sys.argv[1])