# GenAI Weekly Study Prompt Builder

Use this meta prompt with a GenAI tool to create an interactive study prompt for any week in any course. Attach or paste the week's syllabus, objectives, readings, notes, slides, and assignment materials before running it.

```text
You are helping me design a weekly GenAI study prompt for students.

Course: [course name]
Week or unit: [week, module, or chapter]
Audience: [student level and background]
Class goals: [what students should be able to explain, apply, analyze, or create]
Syllabus: [course description, learning objectives, policies, and expectations]
Lecture materials: [lecture notes, slides, videos, transcripts, and required readings]
Assignment materials: [assignment brief, rubric, milestone, starter code, or deliverables]
Schedule: [this week's date, topic, and assignment milestone]
Class format: [discussion, lab, exam review, presentation, or other]
Approximate study time: [number of minutes]

First, inspect the course materials and identify:
1. the central ideas students must understand;
2. the vocabulary, models, procedures, or skills they must use;
3. the misconceptions or failure modes most likely to cause confusion;
4. the kinds of questions or tasks students may face in class;
5. any evidence, source, safety, academic-integrity, or tool-use requirements;
6. how this week's lectures support, lead into, or depend on the assignment;
7. which concepts the student should apply to the assignment and which details are outside this week's scope.

Do not invent course-specific facts. Use the supplied materials as the primary source. Clearly label any general background knowledge or reasonable inference. If the materials conflict, identify the conflict instead of silently choosing one version.

Coordinate the study experience across the course materials. The prompt should prepare students for the week's lecture discussion and help them make progress on the relevant assignment milestone. Connect concepts to assignment decisions, artifacts, or evidence when that connection is supported by the materials. Do not complete the assignment for the student, invent rubric requirements, or introduce later-week content unless it is needed to explain a dependency.

Now write one concise, copy-and-paste-ready prompt that turns a GenAI tool into an interactive study partner for this week. The student-facing prompt must:

- state the subject, week, learning goals, and source boundaries;
- explain how the week's lecture topics connect to the relevant assignment or milestone;
- ask the student for their notes or materials if none are provided;
- begin with 3-5 short diagnostic questions, one at a time;
- wait for the student's answer before continuing;
- explain the student’s reasoning, correct important misconceptions, and use concrete examples;
- guide the student through 2–3 application activities based on realistic scenarios, data, problems, code, cases, or artifacts appropriate to the subject;
- require the student to attempt an answer before revealing a solution, using hints when needed;
- increase or decrease difficulty based on the student’s responses;
- include questions that connect concepts, trade-offs, assumptions, and consequences;
- finish with 5–8 class-style questions, one at a time, followed by targeted review advice;
- end with a short explanation or teach-back task the student could give in class;
- encourage the student to verify important claims against the course materials and document AI assistance when the course requires it.

Keep the final student prompt clear, engaging, and short enough to use in one study session. Prefer active dialogue over a lecture or a long summary. Use the terminology and examples from the course materials, but vary the examples so the student must transfer the ideas to new situations.

After the student-facing prompt, provide a brief instructor note with:
- the learning goals covered;
- the lecture-to-assignment connections used;
- the misconceptions the prompt is designed to surface;
- the application activities used;
- any assumptions or missing source material;
- one suggested revision if the prompt proves too easy or too difficult.
```

The resulting student prompt should be tested with a few representative students or sample responses before it is reused for another week. Revise the source inputs and difficulty controls when the conversation becomes either a passive lecture or a trivia quiz.
