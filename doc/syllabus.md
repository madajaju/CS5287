# **Vanderbilt University – School of Engineering**

## **5287 – Cloud Computing**

**Instructor:** Dr. Darren Pulsipher
**Email:** [darren.pulsipher@vanderbilt.edu](mailto:darren.pulsipher@vanderbilt.edu)
**Meeting Time:** Thursdays, 5:00–6:30 PM CT (Online via Zoom)
**Semester:** Fall 2026

## **Course Description**

This course provides an in-depth understanding of **cloud computing concepts, architectures, and technologies** through a combination of **pre-class recorded lectures**, **weekly discussions**, **hands-on cloud assignments**, and **technical presentations**.

Students will explore cloud infrastructure, virtualization, containers, orchestration, cloud-native development, serverless computing, distributed data management, AI workloads, and next-generation networking.

Instead of traditional lectures, class time will be used for **active discussions**, **breakout sessions**, and **presentations**. Students are expected to **prepare by watching videos, reading assigned materials, and completing assignments** before each session.

## **Instructor Philosophy**

Cloud computing is evolving rapidly, and employers value **applied skills, problem-solving ability, and communication skills**. This course is designed to simulate real-world learning, collaboration, and presentation experiences.

Generative AI (GenAI) will be used throughout the course to assist in **learning, creating, coding, debugging, and presentation preparation**. Students are expected to **learn how to leverage AI tools effectively and responsibly**.

## **Learning Objectives**

By the end of this course, students will be able to:

1. Explain cloud computing models, architectures, and services.
2. Deploy and manage workloads using virtualization, containers, and orchestration tools.
3. Apply scaling, load balancing, and reliability engineering techniques in cloud-native systems.
4. Build and deploy serverless and edge computing applications.
5. Design and implement distributed data management solutions.
6. Leverage cloud resources for AI/ML workloads.
7. Use GenAI tools effectively for technical problem-solving and presentation.
8. Communicate technical concepts clearly in both written and spoken formats.

## **Course Skill Balance**

This course uses the following balance across the semester:

| Area | Focus |
| ---- | -----: |
| SME Skills | 70% |
| AI Skills | 10% |
| Core Skills | 10% |
| Meta Skills | 10% |

The framing is:

* **70% SME Skills**: Can I build it correctly?
* **10% AI Skills**: Can I use AI effectively?
* **10% Core Skills**: Can I communicate and work professionally?
* **10% Meta Skills**: Can I think like an engineer?

## **Integrity Packet**

The Integrity Packet is the course artifact used to capture engineering claims, assumptions, evidence, validation steps, AI-assisted work, and final ownership of a solution. It is required in the first couple of weeks of the course and in every assignment submission.

Students should use it to:

* record what they believe the system does
* document what evidence supports that claim
* show how AI was used, verified, accepted, or rejected
* note assumptions, gaps, and escalation points
* preserve the reasoning that led to the final submission

## **Weekly Learning Objectives**

| Week | Objective |
| ---- | --------- |
| 0 | Establish course expectations, tooling, the integrity packet, and the shared workflow for the semester. |
| 1 | Build foundational understanding of cloud origins, service models, deployment choices, REST, and the integrity packet. |
| 2 | Connect systems, networking, security basics, and integrity-packet evidence collection to cloud behavior. |
| 3 | Compare virtualization and infrastructure automation approaches used to provision cloud resources. |
| 4 | Explain container isolation, image lifecycle, networking, and orchestration basics. |
| 5 | Trace how Kubernetes schedules and connects workloads, including service mesh patterns. |
| 6 | Apply load balancing, scheduling, and autoscaling to keep services responsive. |
| 7 | Analyze tail latency and use observability signals, SLIs, SLOs, and SLAs to define reliable operations. |
| 8 | Apply chaos-engineering principles and experiments to validate system resilience. |
| 9 | Distinguish serverless and edge or fog models and match them to workload patterns. |
| 10 | Compare distributed file systems and sharding strategies for multi-hybrid cloud storage. |
| 11 | Understand batch and distributed data processing frameworks and when to use them. |
| 12 | Evaluate GPU-based cloud execution, LLM serving, and agentic workflow patterns. |
| 13 | Explain SDN, NFV, and 5G integration in modern cloud networking. |
| 14 | Demonstrate and defend the completed final project using architecture, operational evidence, and lessons learned. |

## **Course Structure**

Each week follows this structure:

* **Before Class:** Learn the subject to be discussed in class that week

    * Explore the subject with GenAI
    * Watch 2–3 short pre-recorded lectures
    * Read assigned articles and documentation
    * Work on GitHub cloud assignments

* **During Class:**

    * Quick recap and Q\&A
    * Breakout sessions for collaborative problem-solving
    * Individual student presentations and discussion
    * Feedback from the instructor and peers

* **After Class:**

    * Complete and submit assignments
    * Begin preparing for the next week's topics

## **Required Tools & Resources**

* **GitHub Repo:** [Assignments and Lectures](https://github.com/madajaju/CS5287)
* **Docker Desktop** or equivalent container runtime
* **kubectl** and access to a Kubernetes cluster
* Generative AI tool(s) of choice (ChatGPT, Claude, Gemini, etc.)

## **Use of Generative AI**

Generative AI is **required** in this course as a tool for:

* **Learning** — using AI to explain concepts, answer questions, and explore code
* **Creating** — generating starter code, diagrams, and reports
* **Presenting** — helping prepare slides, outlines, and demos

**Rules for AI Use:**

1. Always verify AI-generated content for accuracy.
2. GenAI is a people pleaser and it will lie straight to your face.
3. Disclose in your assignment write-up where and how AI was used.
4. AI may not be used to generate final code without your review and understanding.
5. Save your conversations with GenAI. Hand them in with assignments. Share them with others.

## **Grading**

| Component                                                                                | Weight |
|------------------------------------------------------------------------------------------| ------ |
| Cloud [Assignments](assignments/README.md) (CA0–CA3)                                   | 40%    |
| [Final Cloud Project](assignments/CA4/README.md) (CA4—deployment, individual demo, and documentation) | 25% |
| Weekly Participation (discussions, breakout work)                                        | 15%    |
| Final Exam – Interview (Need to schedule)                                                | 20%    |

## **Participation Policy**

* If you miss class, you **lose participation points for that class**.
* **No make-up participation** is available.
* Participation includes contributing to **live discussions**, **breakout sessions**, and **individual presentations** during class time.

## **Final Exam – Interview**

The final exam is a **one-on-one technical interview** with Dr. Darren on a topic assigned one week in advance. This simulates **real-world job interviews and conference presentations**. You will:

* Present the assigned topic for 10–15 minutes
* Answer technical follow-up questions
* Be graded on **clarity, accuracy, depth, and communication skills**

## **Weekly Topics & Assignments (Summary)**

| Week | Date | Topics | Assignments |
| --- | --- | --- | --- |
| 0 | Before Aug 27 | Course introduction, repository, and environment setup | Environment setup |
| 1 | Aug 27 | Motivation, models, REST | Assign CA0 |
| 2 | Sep 3 | Systems & networking refresher | Submit CA0 Sep 4 |
| 3 | Sep 10 | Virtualization & infrastructure as code | Assign CA1 |
| 4 | Sep 17 | Containers | Submit CA1 Sep 18 |
| 5 | Sep 24 | Kubernetes & networking | Preview CA2 |
| 6 | Oct 1 | Scaling & scheduling | Start CA2 |
| 7 | Oct 8 | Observability, SRE & tail latency | Continue CA2 |
| 8 | Oct 15 | Chaos engineering | Submit CA2 Oct 16 |
| — | Oct 22 | **Fall break—no class** | — |
| 9 | Oct 29 | Serverless & edge computing | Assign CA3 |
| 10 | Nov 5 | Cloud storage | Submit CA3 Nov 6 |
| 11 | Nov 12 | Data processing frameworks | Start CA4 |
| 12 | Nov 19 | AI in the cloud | Continue CA4 |
| — | Nov 26 | **Thanksgiving break—no class** | — |
| 13 | Dec 3 | Networking innovations | Submit CA4 Dec 4 |
| 14 | Dec 10 | Individual final project demonstrations | Present CA4 |

**Note:** See the [Schedule](Schedule.md) tab for the full schedule and assignment dates.

## Assignments
Assignments will take you through a journey of **learning, creating, coding, debugging, and presentation preparation**.
They walk you through the history and process of cloud deployment, starting with manual deployment and progressing to fully automated multi-cloud deployments.
See the [Assignments](assignments/README.md) page for the full list of assignments.

## **Participation Expectations**

* Come **prepared to discuss the week’s topic** — watching the videos and completing readings before class is mandatory.
* Use **GenAI, Google, Stack Overflow, vendor documentation, and other reputable sources** to deepen your understanding.
* Treat the provided **papers, videos, and tutorials as a starting point**, not the full scope of your learning.
* Engage in breakout sessions and actively contribute to group findings.
* Provide constructive feedback to peers.
* Discuss course concepts constructively with peers while completing and submitting all cloud assignments individually.

## Technology Recording Statement

The following is a general statement distributed by our University with respect to the use of Zoom
and recordings. Vanderbilt University seeks to protect the intellectual property of all our faculty,
and to safeguard the privacy of all our students in online learning environments. To this end,
students may not record, reproduce, screenshot, photograph, or distribute any online content from
their courses, including recordings of in-person or Zoom class sessions, except for their own
personal educational use. Similarly, instructors may not, in general, share recordings of class
activities with individuals not already participating in the class as students, teachers, or guests.
Any recordings by students or instructors generally should be deleted at the end of the semester.
Failure to abide by recording policies may be an Honor Code violation or may result in corrective
action through the University’s accountability process depending on the circumstances.

## Honor Code and Academic Integrity

You are bound by all provisions of the Honor Code, found in the Vanderbilt Student Handbook and
available online at: http://www.vanderbilt.edu/student_handbook/the-honor-system/. Other
pertinent material may be found at the Honor Council’s website,
https://studentorg.vanderbilt.edu/honorcouncil/.
Specific considerations for this course include:
1. All assessed work in this course is individual. Discussion during class and breakout activities is encouraged, but
   every submitted design, implementation, Integrity Packet, demonstration, and presentation must be your own work.
2. If you have questions or concerns about Honor Code issues in this class, please talk
   with me, your professor (Darren Pulsipher).

## Excellence by All

   It is my belief that everyone in this class can excel and that our collective learning experience is
   improved by including everyone fully. Toward that end, I commit to doing my best to use
   inclusive language and practices. If you observe actions in which I am not respectful or
   inclusive, please bring those to my attention ASAP.

## Mental Health & Wellness
   If you are experiencing undue personal and/or academic stress during the semester that may be
   interfering with your ability to perform academically, Vanderbilt’s Student Care Network offers a
   range of services to assist and support you. I am available to speak with you about stresses
   related to your work in my course, and I can assist you in connecting with the Student Care
   Network. The Office of Student Care Coordination
   (https://www.vanderbilt.edu/carecoordination/) is the central and first point of contact to help
   students navigate and connect to appropriate resources on and off-campus. The Student Care
   Network (https://www.vanderbilt.edu/studentcarenetwork/satellite-services/ ) also offers drop-in
   services on campus on a regular basis. If you or someone you know needs to speak with a
   professional counselor immediately, the University Counseling Center
   (https://www.vanderbilt.edu/ucc/ ) offers Crisis Care Counseling.

## Disability Statement
   Vanderbilt is committed to equal opportunity for students with disabilities, as am I. If you need
   course accommodations due to a disability, please contact VU Student Access Services
   (https://www.vanderbilt.edu/student-access/disability/ ) to initiate that process.
   Emergency Evacuation Plan (for on-ground class)
   In the event of a fire or other emergency, the occupants of this class should collect coats and
   personal belongings and leave the building through the exits closest to the classroom and
   utilizing the stairs. VANDERBILT UNIVERSITY POLICY FORBIDS REENTRY TO A BUILDING
   IN WHICH AN ALARM HAS OCCURRED WITHOUT AUTHORIZATION BY VANDERBILT
   SECURITY. If, in consequence of a disability, you anticipate the need for assistance, please
   discuss that need with the instructor/professor.

   For general guidelines, please visit: https://emergency.vanderbilt.edu/vu/quick-ref-
   guides/evacuation.php

   Please familiarize yourselves with the evacuation plans mentioned here for all the buildings in
   VUSE. http://engineering.vanderbilt.edu/about/evacuationplans.php.
