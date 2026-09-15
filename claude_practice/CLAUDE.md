# Claude Code Project Instructions

## Project Overview

This is a large C++ server application running on Linux.

The project may contain:

- C++ server code
- Network handlers
- Database access
- MySQL
- Multi-threaded processing
- Background jobs
- External publisher/payment integrations
- Configuration files
- Build scripts

Follow the existing project architecture and coding conventions.

---

# Subagent Delegation Rules

You have access to specialized subagents.

Use specialized subagents whenever their expertise is relevant.

Do not perform large investigations yourself when a specialized subagent
can perform the investigation more efficiently.

## Explorer

Use `explorer` when:

- The relevant code is unfamiliar.
- The task requires finding where functionality is implemented.
- Multiple files/classes need to be traced.
- Call relationships need to be investigated.
- The impact area is unknown.

Explorer is READ-ONLY.

Typical flow:

User request
→ Explorer
→ findings
→ continue with appropriate specialist

---

## Architect

Use `architect` when:

- A feature requires design decisions.
- Multiple implementation approaches exist.
- Class/module boundaries need to be decided.
- A large refactoring is required.
- API/interface changes are required.
- The implementation impact is significant.

Architect should normally design before implementation.

Typical flow:

Explorer
→ Architect
→ C++ Expert

---

## C++ Expert

Use `cpp-expert` when:

- C++ source code must be implemented or modified.
- A bug needs to be fixed.
- Classes/functions need to be changed.
- Server-side logic needs to be implemented.

Before modifying unfamiliar code, investigate the relevant implementation
first.

Typical flow:

Explorer
→ C++ Expert

or:

Architect
→ C++ Expert

---

## Debugger

Use `debugger` when:

- The server crashes.
- SIGSEGV occurs.
- SIGABRT occurs.
- Core dumps exist.
- A deadlock occurs.
- The process hangs.
- Runtime behavior is abnormal.
- The cause of a bug is unclear.

Debugger should diagnose the root cause before implementation changes.

Typical flow:

Explorer
→ Debugger
→ C++ Expert
→ Test Engineer

---

## Database

Use `database` when:

- MySQL is involved.
- SQL needs to be analyzed.
- Schema differences need to be investigated.
- Indexes need to be reviewed.
- Query performance needs investigation.
- Transactions or locks are involved.
- Database migrations are required.

Typical flow:

Explorer
→ Database
→ C++ Expert

when both application and DB changes are required.

---

## Performance

Use `performance` when:

- CPU usage is high.
- Memory usage is high.
- A function is slow.
- Server latency increased.
- Lock contention is suspected.
- Database/network I/O may be a bottleneck.
- A performance regression is suspected.

Do not optimize without identifying the bottleneck first.

Typical flow:

Explorer
→ Performance
→ C++ Expert
→ Test Engineer

---

## Code Reviewer

Use `code-reviewer` after meaningful source changes.

The reviewer should independently inspect:

- Correctness
- Memory safety
- Lifetime
- Concurrency
- Error handling
- Regression risk
- Maintainability

Do not assume the implementation is correct simply because the coding agent
reported success.

Typical flow:

C++ Expert
→ Code Reviewer

---

## Security Reviewer

Use `security-reviewer` when changes involve:

- Network input
- Authentication
- Authorization
- Payment
- User/account data
- File operations
- SQL
- External commands
- Serialization
- Sensitive information

Security review is especially important for externally reachable server code.

Typical flow:

C++ Expert
→ Security Reviewer
→ Test Engineer

---

## Test Engineer

Use `test-engineer` after feature implementation or bug fixes.

The test engineer should identify:

- Normal cases
- Boundary cases
- Invalid input
- Concurrent behavior
- Disconnects
- Timeouts
- Duplicate requests
- Regression cases

Run tests when possible.

Never claim that tests passed unless they were actually executed.

Typical flow:

C++ Expert
→ Test Engineer

---

## Release Checker

Use `release-checker` before:

- Merge
- Production deployment
- Release
- Large configuration changes
- Database migrations
- Major server changes

Verify:

- Build
- Tests
- Configuration
- Dependencies
- Database impact
- Deployment requirements
- Rollback plan

Typical flow:

Code Reviewer
→ Release Checker

---

# Automatic Delegation

Do not require the user to explicitly name a subagent.

Infer the appropriate specialists from the task.

For simple tasks, do not unnecessarily invoke many agents.

For complex tasks, use multiple specialists when their responsibilities are
independent and materially useful.

Prefer this general workflow:

## New Feature

Explorer
→ Architect (if design is non-trivial)
→ C++ Expert
→ Test Engineer
→ Code Reviewer
→ Security Reviewer (if security-sensitive)
→ Performance (if performance-sensitive)
→ Release Checker (before release)

## Bug Fix

Explorer
→ Debugger
→ C++ Expert
→ Test Engineer
→ Code Reviewer

## Database Problem

Explorer
→ Database
→ C++ Expert (if application code is affected)
→ Test Engineer

## Performance Problem

Explorer
→ Performance
→ C++ Expert
→ Test Engineer
→ Code Reviewer

## Crash / Core Dump

Explorer
→ Debugger
→ C++ Expert
→ Test Engineer
→ Code Reviewer

## Code Review Only

Code Reviewer

Do not modify code unless explicitly requested.

---

# Important Delegation Principles

1. Investigate before modifying unfamiliar code.

2. Do not delegate every trivial task.

3. Prefer specialized agents for large or complex investigations.

4. Do not duplicate the same work across multiple agents.

5. When two agents can work independently, they may be run independently.

6. When one agent's output is required by another, perform them sequentially.

7. Keep the main context focused on the overall task.

8. Always verify important changes before declaring completion.

9. Never claim that an agent ran if it did not actually run.

10. Never claim tests passed without executing them.

---

# Code Modification Policy

Before modifying code:

1. Understand the existing implementation.
2. Identify affected files.
3. Check related callers.
4. Check error handling.
5. Check ownership/lifetime.
6. Check concurrency if applicable.

Make the smallest change that correctly solves the problem.

Do not refactor unrelated code.

---

# Final Verification

For meaningful code changes, prefer:

Implementation
→ Test
→ Code Review

For release-related work:

Implementation
→ Test
→ Code Review
→ Release Checker