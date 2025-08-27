"""
Pattern library for Beacon application.
Defines standard structural patterns to detect in Neo4j graphs.
"""

import json
import os
from typing import Dict, List, Optional

class PatternLibrary:
    """Library of graph patterns for Beacon application"""
    
    def __init__(self, patterns_file: Optional[str] = None):
        self.patterns_file = patterns_file or "patterns.json"
        self.patterns = self._load_patterns()
    
    def _load_patterns(self) -> Dict:
        """Load patterns from file or return default patterns"""
        if os.path.exists(self.patterns_file):
            try:
                with open(self.patterns_file, 'r') as f:
                    return json.load(f)
            except Exception as e:
                print(f"Error loading patterns: {e}")
                return self._get_default_patterns()
        else:
            return self._get_default_patterns()
    
    def _get_default_patterns(self) -> Dict:
        """Return default pattern definitions"""
        return {
            "directors_inner_circle": {
                "id": "directors_inner_circle",
                "name": "Director's Inner Circle",
                "description": "Directors who frequently work with the same actors",
                "category": "Collaboration",
                "complexity": "Medium",
                "query": """
                MATCH (d:Director)-[:DIRECTED]->(m:Movie)<-[:ACTED_IN]-(a:Actor)
                WITH d, a, count(m) as collaborations
                WHERE collaborations >= 3
                RETURN d.name as director, a.name as actor, collaborations
                ORDER BY collaborations DESC
                """
            },
            "actor_collaborations": {
                "id": "actor_collaborations",
                "name": "Actor Collaborations",
                "description": "Actors who frequently appear in movies together",
                "category": "Collaboration",
                "complexity": "Medium",
                "query": """
                MATCH (a1:Actor)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(a2:Actor)
                WHERE a1 <> a2
                WITH a1, a2, count(m) as movieCount
                WHERE movieCount >= 2
                RETURN a1.name as actor1, a2.name as actor2, movieCount
                ORDER BY movieCount DESC
                """
            },
            "genre_clusters": {
                "id": "genre_clusters",
                "name": "Genre Clusters",
                "description": "Actors who primarily work in specific genres",
                "category": "Specialization",
                "complexity": "High",
                "query": """
                MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)-[:IN_GENRE]->(g:Genre)
                WITH a, g, count(m) as genreMovies
                WITH a, collect({genre: g.name, count: genreMovies}) as genreCounts
                UNWIND genreCounts as gc
                WITH a, gc.genre as primaryGenre, gc.count as count
                ORDER BY count DESC
                WITH a, head(collect({genre: primaryGenre, count: count})) as primary
                WHERE primary.count >= 3
                RETURN a.name as actor, primary.genre as primaryGenre, primary.count as movies
                ORDER BY primary.count DESC
                """
            }
        }
    
    def get_all_patterns(self) -> List[Dict]:
        """Get all available patterns"""
        return list(self.patterns.values())
    
    def get_pattern(self, pattern_id: str) -> Optional[Dict]:
        """Get a specific pattern by ID"""
        return self.patterns.get(pattern_id)
    
    def add_pattern(self, pattern: Dict) -> bool:
        """Add a new pattern to the library"""
        try:
            pattern_id = pattern.get('id')
            if not pattern_id:
                return False
            
            self.patterns[pattern_id] = pattern
            self._save_patterns()
            return True
        except Exception as e:
            print(f"Error adding pattern: {e}")
            return False
    
    def update_pattern(self, pattern_id: str, pattern: Dict) -> bool:
        """Update an existing pattern"""
        try:
            if pattern_id not in self.patterns:
                return False
            
            pattern['id'] = pattern_id
            self.patterns[pattern_id] = pattern
            self._save_patterns()
            return True
        except Exception as e:
            print(f"Error updating pattern: {e}")
            return False
    
    def delete_pattern(self, pattern_id: str) -> bool:
        """Delete a pattern from the library"""
        try:
            if pattern_id not in self.patterns:
                return False
            
            del self.patterns[pattern_id]
            self._save_patterns()
            return True
        except Exception as e:
            print(f"Error deleting pattern: {e}")
            return False
    
    def _save_patterns(self) -> None:
        """Save patterns to file"""
        try:
            with open(self.patterns_file, 'w') as f:
                json.dump(self.patterns, f, indent=2)
        except Exception as e:
            print(f"Error saving patterns: {e}")
    
    def search_patterns(self, query: str) -> List[Dict]:
        """Search patterns by name or description"""
        query = query.lower()
        results = []
        
        for pattern in self.patterns.values():
            if (query in pattern.get('name', '').lower() or 
                query in pattern.get('description', '').lower() or
                query in pattern.get('category', '').lower()):
                results.append(pattern)
        
        return results

