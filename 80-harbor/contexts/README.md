# Context Initialization Templates (CITs)

This folder contains Context Initialization Templates (CITs) that capture cognitive frameworks and thinking patterns for consistent AI collaboration.

## What are CITs?

Context Initialization Templates are structured documents that define:
- **Cognitive frameworks** - How to approach problems and think about solutions
- **Communication parameters** - How information should be structured and presented
- **Interaction protocols** - Step-by-step processes for collaboration
- **Output formatting** - How responses should be organized and presented
- **Conceptual alignment** - The underlying philosophy and approach

## Current CITs

### META-CIT: Framework Generation Template v1.1
**Purpose**: Template for creating other CITs
**Use Case**: When you want to formalize a new cognitive framework
**Location**: `META_CIT.md`
**Relationship**: Meta-framework for creating other CITs

### H.A.R.B.O.R.: Maritime Data Exploration Ecosystem v1.0
**Purpose**: Complete project context and ecosystem overview
**Use Case**: General Harbor project work and ecosystem understanding
**Location**: `HARBOR_CIT.md`
**Relationship**: Main ecosystem CIT, contains all project context

### H.A.R.B.O.R. Applications: Specialized Tools CIT v1.0
**Purpose**: Detailed application-specific guidance
**Use Case**: Working with specific Harbor applications (Beacon, Coastal Explorer, etc.)
**Location**: `APPLICATIONS_CIT.md`
**Relationship**: Specialized CIT for application-specific work

### H.A.R.B.O.R. Technical Setup: Infrastructure CIT v1.0
**Purpose**: Technical setup, configuration, and infrastructure
**Use Case**: System setup, troubleshooting, and technical infrastructure
**Location**: `TECHNICAL_SETUP_CIT.md`
**Relationship**: Specialized CIT for technical implementation

## CIT Hierarchy and Relationships

```
META-CIT (v1.1)
├── HARBOR_CIT (v1.0) - Main ecosystem context
│   ├── APPLICATIONS_CIT (v1.0) - Application-specific details
│   └── TECHNICAL_SETUP_CIT (v1.0) - Technical infrastructure
└── [Future CITs] - Additional specialized contexts
```

### Framework Relationships
- **META-CIT**: Meta-level framework for creating other frameworks
- **HARBOR_CIT**: Domain-specific framework for Harbor ecosystem
- **APPLICATIONS_CIT**: Nested framework for application-specific work
- **TECHNICAL_SETUP_CIT**: Nested framework for technical implementation

## How to Use CITs

### 1. Choose the Right CIT
- **General Harbor work**: Use `HARBOR_CIT.md`
- **Application-specific work**: Use `APPLICATIONS_CIT.md`
- **Technical setup/troubleshooting**: Use `TECHNICAL_SETUP_CIT.md`
- **Creating new frameworks**: Use `META_CIT.md`

### 2. Initialize a Conversation
Copy the relevant CIT content and paste it at the beginning of a new AI conversation. This sets the cognitive framework for the entire interaction.

### 3. Combine with Domain Content
After the CIT, provide specific context about your project, problem, or domain. The CIT will structure how the AI approaches this content.

### 4. Framework Relationships
CITs can be:
- **Complementary**: Address different aspects of cognition
- **Sequential**: Naturally follow each other in process
- **Nested**: Operate at different levels of the same domain
- **Orthogonal**: Intersect but focus on different dimensions

## Creating New CITs

Use the META-CIT template to create new CITs:

1. **Identify a coherent cognitive framework** in your work
2. **Extract the essential elements** using the META4 process:
   - Metadata: Core attributes and preferences
   - Extraction: Essential thinking elements
   - Template: Structured protocols
   - Assembly: Complete formatting
   - Metaphor: Conceptual alignment
3. **Test and refine** the CIT with actual conversations
4. **Version and maintain** the CIT as it evolves

## CIT Structure

Every CIT should include:

```markdown
# [NAME]: [SUBTITLE] v[VERSION]
## Cognitive Structure for [DOMAIN]

## COGNITIVE FRAMEWORK: [APPROACH]
* Primary Mode: [main processing approach]
* Information Preference: [how information is preferred]
* Learning Style: [characteristic learning approach]

## COMMUNICATION PARAMETERS
{
  "parameter1": "value",
  "parameter2": "value",
  ...
}

## INTERACTION PROTOCOL
1. [first step]
2. [second step]
...

## 🔔 CONVERSATION REMINDERS
[Reminder protocols for long conversations]

## OUTPUT FORMATTING
* [format instruction 1]
* [format instruction 2]
...

## CONCEPTUAL ALIGNMENT
[summary of essential perspective and approach]
```

## Benefits of CITs

- **Consistency**: Same cognitive approach across conversations
- **Efficiency**: No need to re-explain thinking patterns
- **Portability**: Frameworks can be applied to different domains
- **Evolution**: Frameworks can be refined and improved over time
- **Collaboration**: Teams can share and use the same cognitive approaches
- **Specialization**: Different CITs for different types of work

## Best Practices

1. **Start with the Right CIT**: Choose the most appropriate CIT for your work
2. **Combine CITs**: Use multiple CITs when working across different domains
3. **Test Extensively**: Use CITs in real conversations to refine them
4. **Version Control**: Track changes and improvements
5. **Document Relationships**: Note how CITs relate to each other
6. **Domain Adaptation**: Adapt frameworks for specific use cases

## Example Usage

### General Harbor Work
```
[Paste HARBOR_CIT content here]

Now, let's work on improving the Beacon application's pattern detection...
```

### Application-Specific Work
```
[Paste APPLICATIONS_CIT content here]

I need to add a new feature to Coastal Explorer for schema validation...
```

### Technical Setup
```
[Paste TECHNICAL_SETUP_CIT content here]

I'm having trouble connecting Ocean Explorer to my Neo4j database...
```

### Creating New Frameworks
```
[Paste META-CIT content here]

I've developed a new approach to data visualization that I'd like to formalize...
```

## Harbor Ecosystem Context

The Harbor CITs work together to provide comprehensive coverage of the Harbor ecosystem:

- **HARBOR_CIT**: Complete ecosystem overview, philosophy, and context
- **APPLICATIONS_CIT**: Detailed application capabilities and integration
- **TECHNICAL_SETUP_CIT**: Infrastructure, setup, and technical implementation
- **META_CIT**: Framework for creating additional specialized CITs

This creates a layered approach where you can:
1. Start with the main ecosystem context (HARBOR_CIT)
2. Dive into specific application details (APPLICATIONS_CIT)
3. Handle technical implementation (TECHNICAL_SETUP_CIT)
4. Create new specialized frameworks (META_CIT)

---

*CITs represent a new approach to AI collaboration that prioritizes cognitive frameworks over domain-specific knowledge, enabling more consistent and effective human-AI partnerships. The Harbor ecosystem demonstrates how multiple specialized CITs can work together to provide comprehensive coverage of complex systems.* 