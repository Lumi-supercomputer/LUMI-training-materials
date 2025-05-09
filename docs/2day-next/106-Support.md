# LUMI Support and Documentation

## Distributed nature of LUMI support

<figure markdown style="border: 1px solid #000">
  ![Distributed nature of support (1)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/DistributedNature1.png){ loading=lazy }
</figure>

<!-- BELGIUM
<figure markdown style="border: 1px solid #000">
  ![Distributed nature of support (2)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/DistributedNature2.png){ loading=lazy }
</figure>
-->

User support for LUMI comes from several parties. Unfortunately, as every participating consortium countries
has some responsibilities also and solves things differently, there is no central point where you can go
with all questions.

<!-- BELGIUM>
Resource allocators work independently from each other and the central LUMI User Support Team. This also 
implies that they are the only ones who can help you with questions regarding your allocation: How to apply
for compute time on LUMI, add users to your project, running out of resources (billing units) for your project, failure
to even get access to the portal managing the allocations given by your resource allocator (e.g., because
you let expire an invite), ... 
For projects allocated in the Belgian allocation, help can be requested via the email address
lumi-be-support@enccb.be. However, we cannot help you with similar problems for compute time directly 
obtained via EuroHPC.
For granted EuroHPC projects, support is available via lumi-customer-accounts@csc.fi, but you will have
to contact EuroHPC directly at access@eurohpc-ju.europa.eu if, e.g., you need more resources or an 
extension to your project.
-->

<!-- GENERAL More general version -->
Resource allocators work independently from each other and the central LUMI User Support Team. This also 
implies that they are the only ones who can help you with questions regarding your allocation: How to apply
for compute time on LUMI, add users to your project, running out of resources (billing units) for your project, failure
to even get access to the portal managing the allocations given by your resource allocator (e.g., because
you let expire an invite), ... 
For granted EuroHPC projects, support is available via lumi-customer-accounts@csc.fi, but you will have
to contact EuroHPC directly at access@eurohpc-ju.europa.eu if, e.g., you need more resources or an 
extension to your project.

The central LUMI User Support Team (LUST) offers L1 and basic L2 support. 
Given that the LUST team is very small compared to the number of project granted annually on LUMI 
(roughly 10 FTE for on the order of 700 projects per year, and support is not their only task),
it is clear that the amount of support they can give is limited. 
E.g., don't expect them to install all software you request for them. There is simply too much
software and too much software with badly written install code to do that with that number
of people. Nor should you expect domain expertise from them. Though several members of the LUST
have been scientist before, it does not mean that they can understand all scientific problems thrown
at them or all codes used by users. Also, the team cannot fix bugs for you in the codes that you use,
and usually not in the system code either. For fixing bugs in HPE or AMD-provided software, they are
backed by a team of experts from those companies. However, fixing bugs in compilers or libraries 
and implementing those changes on the system takes
time.
The system software on a big shared machine cannot be upgraded as easily as on a personal workstation.
Usually you will have to look for workarounds, or if they show up in a preparatory project,
postpone applying for an allocation until all problems are fixed.

<!-- BELGIUM
In Flanders, the VSC has a Tier-0 support project to offer more advanced L2 and some L3 support.
The project unfortunately is not yet fully staffed.
VSC Tier-0 support can be contacted via the LUMI-BE help desk at lumi-be-support@enccb.be (the same
help desk that you need to contact for allocation problems).
-->

<!-- BELGIUM>
In the Walloon region, there is some limited advanced support via Orian Louant. However, this is only a part of
all his tasks. Here also the lumi-be-support@enccb.be mail address can be used.
-->

<!-- BELGIUM
EuroHPC has also granted the [EPICURE project](https://epicure-hpc.eu/) that started in February 2024 to set up a network for
advanced L2 and L3 support across EuroHPC centres. Belgium also participates in that project as a partner
in the LUMI consortium. However, this project is also so small that it will have to select the problems
they tackle.
Moreover, access is only for EuroHPC extreme scale, regular or development projects,
though development projects are relatively easy to get without too much administration.
Yet, this only makes sense for a sufficiently large project with a long enough duration.
-->

<!-- GENERAL More general version -->
EuroHPC has also granted the [EPICURE project](https://epicure-hpc.eu/) that started in February 2024 to set up a network for
advanced L2 and L3 support across EuroHPC centres. At the time of the course, the project is still in
its startup phase. Moreover, this project is also so small that it will have to select the problems
they tackle.
Moreover, access is only for EuroHPC extreme scale, regular or development projects,
though development projects are relatively easy to get without too much administration.
Yet, this only makes sense for a sufficiently large project with a long enough duration.

In principle the EuroHPC Centres of Excellence should also play a role in porting some applications in their
field of expertise and offer some support and training, but so far especially the support and training are
not yet what one would like to have.

Basically given the growing complexity of scientific computing and diversity in the software field, what one
needs is the equivalent of the "lab technician" that many experimental groups have who can then work with 
various support instances, a so-called [Research Software Engineer](https://researchsoftware.org/)...


## Support level 0: Help yourself!

Support starts with taking responsibility yourself and use the available sources of information
before contacting support. Support is not meant to be a search assistant for already available 
information.

The LUMI User Support Team has prepared trainings and a lot of documentation about LUMI.
Good software packages also come with documentation, and usually it is possible to find trainings for 
major packages. And a support team is also not there to solve communication problems in the 
team in which you collaborate on a project!


### Take a training!

<figure markdown style="border: 1px solid #000">
  ![L0 support: Take a training!](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/L0Training.png){ loading=lazy }
</figure>

There exist system-specific and application-specific trainings. 
Ideally of course a user would want a one-step solution, having a training for a specific application on
a specific system (and preferably with the workflow tools they will be using, if any), but that is simply
not possible. The group that would be interested in such a training is for most packages too small, and
it is nearly impossible to find suitable teachers for such course given the amount of expertise that is needed
in both the specific application and the specific system. It would also be hard to repeat such a training
with a high enough frequency to deal with the continuous inflow of new users.

The LUMI User Support Team organises 2 system-specific trainings:

<!-- BELGIUM
1.  There is a 2-day introductory course entirely given by members of the LUST.
    The training does assume familiarity with HPC systems, e.g., obtained from the introductory
    courses taught by [VSC](https://www.vscentrum.be/vsctraining) and
    [CÉCI](https://www.ceci-hpc.be/training.html).

    The course is basically equivalent to this training.
-->

<!-- GENERAL More general version -->
1.  There is a 2-day introductory course entirely given by members of the LUST.
    The training does assume familiarity with HPC systems, and each local organisation
    should offer such courses for their local systems already.

2.  And there is a 4-day advanced training or 5-day training that includes the introductory one
    with more attention on how to run efficiently, and on the
    development and profiling tools. Even if you are not a developer, you may benefit from more knowledge
    about these tools as especially a profiler can give you insight in why your application does not run
    as expected.

<!-- BELGIUM
This particular training is similar to the 2-day LUMI training offered by the LUST
(in fact, the LUST training borrowed a lot of materials from this one), but has been enriched with 
links to the situation specifically in Belgium.
-->

Application-specific trainings should come from other instances though that have the necessary domain
knowledge: Groups that develop the applications, user groups, the EuroHPC Centres of Excellence, ...

What users really want is of course a training for a specific application on a specific system,
but as most applications have a too small usergroup and within that usergroup often still a large variety of workflows, and teaching such a course also requires an instructor with a lot of domain knowledge in the science field of the application.
EuroHPC is also setting up some support initiatives specifically for AI, including the AI
factories, more oriented towards industry startups, and the MINERVA project.

Currently the training landscape in Europe is not too well organised. EuroHPC is starting some new
training initiatives to succeed the excellent PRACE trainings.
Moreover, CASTIEL, the centre coordinating the National Competence Centres and EuroHPC Centres of Excellence also 
[tries to maintain an overview of available trainings](https://www.eurocc-access.eu/services/training/)
(and several National Competence Centres organise trainings open to others also).


### Read/search the documentation

The LUST has developed extensive documentation for LUMI. That documentation is split in two parts:

1.  The [main documentation at docs.lumi-supercomputer.eu](https://docs.lumi-supercomputer.eu/)
    covers the LUMI system itself and includes topics such as how to get on the 
    system, where to place your files, how to start jobs, how to use the programming environment,
    how to install software, etc.

    <figure markdown style="border: 1px solid #000">
      ![L0 support: Check the docs! (1)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/L0ReadTheDocs1.png){ loading=lazy }
    </figure>

2.  The [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) contains
    an overview of software pre-installed on LUMI or for which we have install recipes to start from.
    For some software packages, it also contains additional information on how to use the software
    on LUMI.

    <figure markdown style="border: 1px solid #000">
      ![L0 support: Check the docs! (3)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/L0ReadTheDocs3.png){ loading=lazy }
    </figure>

    That part of the documentation is generated automatically from information in the various repositories
    that are used to manage those installation recipes. It is kept deliberately separate, partly to have
    a more focused search in both documentation systems and partly because it is managed and updated
    very differently.

Both documentation systems contain a search box which may help you find pages if you cannot find them 
easily navigating the documentation structure. E.g., you may use the search box in the LUMI Software Library
to search for a specific package as it may be bundled with other packages in a single module with a 
different name. 

Some examples:

1.  Search in the [main documentation at docs.lumi-supercomputer.eu](https://docs.lumi-supercomputer.eu/) 
    for "quota" and it will take you to pages that among other things
    explain how much quota you have in what partition.

    <figure markdown style="border: 1px solid #000">
      ![L0 support: Check the docs! (2)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/L0ReadTheDocs2.png){ loading=lazy }
    </figure>

2.  Users of the Finnish national systems have been told to use a tool called "Tykky"
    to pack conda and Python installations to reduce the stress on the filesystems and
    wonder if that tool is also on LUMI. So let's search in the
    [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/):

    <figure markdown style="border: 1px solid #000">
      ![L0 support: Check the docs! (4)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/L0ReadTheDocs4.png){ loading=lazy }
    </figure>

    It is, but with a different name as foreigners can't pronounce those Finnish names
    anyway and as something more descriptive was needed.

3.  Try searching for the `htop` command in the 
    [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
    
    <figure markdown style="border: 1px solid #000">
      ![L0 support: Check the docs! (5)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/L0ReadTheDocs5.png){ loading=lazy }
    </figure>

    So yes, `htop` is on LUMI, but if you read the page you'll see it is in a module
    together with some other small tools.


### Talk to your colleagues

<figure markdown style="border: 1px solid #000">
  ![L0 support: Talk to your colleagues](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/L0Colleagues.png){ loading=lazy }
</figure>

A LUMI project is meant to correspond to a coherent research project in which usually multiple
people collaborate. 

This implies that your colleagues may have run in the same problem and may already have a solution,
or they didn't even experience it as a problem and know how to do it. So talk to your colleagues first.

Support teams are not meant to deal with your team's communication problems. There is nothing worse than
having the same question asked multiple times from different people in the same project.
As a project does not have a dedicated support engineer, the second time a question is asked it may
land at a different person in the support team so that it is not recognized that the question has been asked
already and the answer is readily available, resulting in a loss of time for the support team and other,
maybe more important questions, remaining unanswered. 
Similarly bad is contacting multiple help desks with the same question without telling them, as that will
also duplicate efforts to solve a question. We've seen it often that users contact both a local help desk
and the LUST help desk without telling.

Resources on LUMI are managed on a project basis, not on a user-in-project basis, so if you want to know what
other users in the same project are doing with the resources, you have to talk to them and not to the LUST.
We do not have systems in place to monitor use on a per-user, per-project basis, only on a per-project basis,
and also have no plans to develop such tools as a project is meant to be a close collaboration of all
involved users.

LUMI events and on-site courses are also an excellent opportunity to network with more remote
colleagues and learn from them! Which is why we favour on-site participation for courses. 
No video conferencing system can give you the same experience as being physically present
at a course or event.


## L1 and basic L2 support: LUST

<figure markdown style="border: 1px solid #000">
  ![L1 and basic L2: LUST (1)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/LUST1.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![L1 and basic L2: LUST (2)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/LUST2.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![L1 and basic L2: LUST (3)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/LUST3.png){ loading=lazy }
</figure>

The LUMI User Support Team is responsible for providing L1 and basic L2 support to users of the system.
Their work starts from the moment that you have userid on LUMI (the local Resource Allocator is responsible for ensuring
that you get a userid when a project has been assigned).

<!-- BELGIUM
The LUST is a distributed team roughly 10 FTE strong, with people in all LUMI consortium countries,
but they work as a team, coordinated by CSC. The Belgian contribution currently consists of two people
both working half time for LUMI and half time for user support in their own organisation (VSC and CÉCI).
However, you will not necessarily be helped by one of the Belgian team members when you contact LUST, but
by the team member who is most familiar with your problem. 
-->

<!-- GENERAL More general version -->
The LUST is a distributed team roughly 10 FTE strong, with people in all LUMI consortium countries,
but they work as a team, coordinated by CSC. 10 of the LUMI consortium countries each have one or more
members in LUST.
However, you will not necessarily be helped by one of the team members from your own country,
even when you are in a consortium country, when you contact LUST, but
by the team member who is most familiar with your problem. 

There are some problems that we need to pass on to HPE or AMD, particularly if it may be caused by 
bugs in system software, but also because they have more experts with in-depth knowledge of very specific
tools. 

The LUMI help desk is staffed from Monday till Friday between 8am and 6pm Luxembourg time (CE(S)T) except on public holidays
in Finland. You can expect a same day first response if your support query is well formulated and submitted long
enough before closing time, but a full solution of your problem may of course take longer, depending on how busy
the help desk is and the complexity of the problem.

Data security on LUMI is very important. Some LUMI projects may host confidential data, and especially industrial
LUMI users may have big concerns about who can access their data. 
Therefore only very, very few people on LUMI have the necessary rights to access user data on the system,
and those people even went through a background check. The LUST members do not have that level of access,
so we cannot see your data and you will have to pass all relevant information to the LUST through other means!

The LUST help desk should be contacted through 
[web forms in the "User Support - Contact Us" section of the main LUMI web site](https://lumi-supercomputer.eu/user-support/need-help/).
The page is also linked from the ["Help Desk" page in the LUMI documentation](https://docs.lumi-supercomputer.eu/help desk/).
These forms help you to provide more information that we need to deal with your support request.
Please do not email directly to the support web address (that you will know as soon as we answer at ticket as that
is done through e-mail).
Also, separate issues should go in separate tickets so that separate people in the LUST can deal with them,
and you should not reopen an old ticket for a new question, also because then only the person who dealt with
the previous ticket gets notified, and they may be on vacation or even not work for LUMI anymore, so your new
request may remain unnoticed for a long time.


## Tips for writing good tickets that we can answer promptly

### How not to write a ticket

<figure markdown style="border: 1px solid #000">
  ![How not to write a ticket](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/TicketsHowNot.png){ loading=lazy }
</figure>

-   Use a meaningful subject line. All we see in the ticket overview is a number and the subject
    line, so we need to find back a ticket we're working on based on that information alone.

    Yes, we have a user on LUMI who managed to send 8 tickets in a short time with the
    subject line "Geoscience" but 8 rather different problems...

    Hints: 
    
    -   For common problems, including your name in the subject may be a good idea.
    -   For software problems, including the name of the package helps a lot. So not
        "Missing software" but "Need help installing QuTiP 4.3.1 on CPU".
        Or not "Program crashes" but "UppASD returns an MPI error when using more than 1000 ranks".

-   Be accurate when describing the problem. Support staff members are not clairvoyants with
    mysterious superpowers who can read your mind across the internet. 

    We'll discuss this a bit more further in this lecture.

-   If you have no time to work with us on the problem yourself, then tell so.

    Note: The priorities added to the ticket are currently rather confusing. You have three choices
    in the forms: "It affects severely my work", "It is annoying, but I can work", and 
    "I can continue to work normally", which map to "high", "medium" and "low". 
    So tickets are very easily marked as high priority because you cannot work on LUMI, even
    though you have so much other work to do that it is really not that urgent or that you 
    don't even have time to answer quickly.

The improved version could be something like this:

<figure markdown style="border: 1px solid #000">
  ![Improved version login ticket](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/TicketsImprovedLogin.png){ loading=lazy }
</figure>

-   The subject line makes it stand out as the person doing login tickets can quickly find back
    the ticket.

-   There is already a lot of useful information in the ticket:

    -   When did the user first notice the problem, and has it worked before (and when)?

    -   The user clearly tried to check if anything has changed on their side, and in this case at least
        the configuration files of the ssh client have remained unchanged.

    -   We know what client the user is using and luckily it is a standard one so that we know ourselves
        how to use it (apart from local permission problems, but since it still works on the local cluster,
        permissions on files in the local .ssh directory cannot be the issue here). Hence we can tell the user
        how to gather more information. (Unfortunately, some users use exotic ssh clients that we cannot even
        have access to without taking licenses, but expect us to be able to support them...)

    -   It is also useful to know that it is not a one-time hiccup.


## How to write tickets

### 1 ticket = 1 issue = 1 ticket

<figure markdown style="border: 1px solid #000">
  ![1 ticket = 1 issue = 1 ticket](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/Tickets1issue1ticket.png){ loading=lazy }
</figure>

-   If you have multiple unrelated issues, submit them as multiple tickets. In a support team, each member
    has their own specialisation so different issues may end up with different people. Tickets need to be
    assigned to people who will deal with the problem, and it becomes very inefficient if multiple people 
    have to work on different parts of the ticket simultaneously.
    
    Moreover, the communication
    in a ticket will also become very confusing if multiple issues are discussed simultaneously.

-   Conversely, don't submit multiple tickets for a single issue just because you are too lazy to
    look for the previous e-mail if you haven't been able to do your part of the work for some days.
    If you've really lost the email, at least tell us that it is related to a previous ticket so that
    we can try to find it back.

    So keep the emails you get from the help desk to reply!

-   Avoid reusing exactly the same subject line. Surely there must be something different for the new
    problem?

-   Avoid reopening old tickets that have been closed long ago.

    If you get a message that a ticket has been closed (basically because there has been no reply for
    several weeks so we assume the issue is not relevant anymore) and you feel it should not have been
    closed, reply immediately.

    When you reply to a closed ticket and the person who did the ticket is not around (e.g., on vacation
    or left the help desk team), your reply may get unnoticed for weeks. Closed tickets are not passed
    to a colleague when we go on a holiday or leave.

-   Certainly do not reopen old tickets with new issues. Apart from the fact that the person who did
    the ticket before may not be around, they may also have no time to deal with the ticket quickly
    or may not even be the right person to deal with it.


### The subject line is important!

<figure markdown style="border: 1px solid #000">
  ![Subject line is important](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/TicketsSubject.png){ loading=lazy }
</figure>

-   The support team has two identifiers in your ticket: Your mail address and the subject that you 
    specified in the form (LUST help desk) or email (LUMI-BE help desk). So:

    -   Use consistently the same mail address for tickets. This helps us locate previous requests from
        you and hence can give us more background about what you are trying to do. 

        The help desk is a professional service, and you use LUMI for professional work, so use your
        company or university mail address and not some private one.

    -   Make sure your subject line is already descriptive and likely unique in our system.

        We use the subject line to distinguish between tickets we're dealing with so make sure that it can easily
        be distinguished from others and is easy to find back.

-   So include relevant keywords in your subject, e.g.,

    -   The userid you were using and the way of logging in to the system for login problems.

    -   Name of software packages for software installations or crashes.

Some proper examples are

-   User abcdefgh cannot log in via web interface

    So we know we may have to pass this to our Open OnDemand experts, and your userid makes
    the message likely unique. Moreover, after looking into account databases etc., we can
    immediately find back the ticket as the userid is in the subject.

-   ICON installation needs libxml2

-   VASP produces MPI error message when using more than 1024 ranks


### Think with us

<figure markdown style="border: 1px solid #000">
  ![Think with us (1)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/TicketsThinkWithUs1.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![Think with us (2)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/TicketsThinkWithUs2.png){ loading=lazy }
</figure>

<!-- This is the general version only, there are too many layout problems trying to combine multiple versions. -->
-   Provide enough information for us to understand who you are:

    -   Name: and the name as we would see it on the system, not some nickname.

    -   Userid: Important especially for login problems.

    -   Project number:

        -   When talking to the LUST: they don't know EuroHPC or your local organisation's project numbers, only
            the 462xxxxxx and 465xxxxxx numbers, and that is what they need.
        -   If you have a local support organisation though, the local project number may be
            useful for them, as it may then land with someone who does not have access to the 
            LUMI project numbers of all projects they manage.

-   For login and data transfer problems, your client environment is often also important to diagnose
    the problem. 

    -   This does include your geographical location. Doing things from work may have different issues
        then doing things from your home connection, and being abroad may be part of the problem!

        -   Extreme example: Iran blocks most encrypted internet traffic going abroad.
            This is an extreme example though as you are not allowed to use LUMI while being in Iran as
            it breaks the US export restrictions and hence the LUMI conditions of use.

-   What software are you using, and how was it installed or where did you find it?

    We know that certain installation procedures (e.g., simply downloading a binary) may cause
    certain problems on LUMI. Also, there are some software installations on LUMI for which neither
    LUST nor the local help desk is responsible, so we need to direct to to their support instances
    when problems occur that are likely related to that software.

-   Describe your environment (though experience learns that some errors are caused by users
    not even remembering they've changed things while those changes can cause problems)

    -   Which modules are you using?

    -   Do you have special stuff in `.bashrc` or `.profile`? 

    -   For problems with running jobs, the batch script that you are using can be very useful.

-   Describe what worked so far, and if it ever worked: when? E.g., was this before a system update?

    The LUST has had tickets were a user told that something worked before but as we questioned further
    it was long ago before a system update that we know broke some things that affects some programs...

-   What did you change since then? Think carefully about that. When something worked some time ago but
    doesn't work know the cause is very often something you changed as a user and not something going on
    on the system.

-   What did you already try to solve the problem?

-   How can we reproduce the problem? A simple and quick reproducer speeds up the time to answer your ticket.
    Conversely, if it takes a 24-hour run on 256 nodes to see the problem it is very, very likely that the 
    support team cannot help you.

    Moreover, if you are using licensed software with a license that does not cover the support team members,
    usually we cannot do much for you. LUST will knowingly violate
    software licenses only to solve your problems (and neither will your local support team)!

-   The LUST help desk members know a lot about LUMI but they are (usually) not researchers in
    your field so cannot help you with problems that require domain knowledge in your field. We can impossibly
    know all software packages and tell you how to use them (and, e.g., correct errors in your input files).
    And the same likely holds for your local support organisation.

    You as a user should be the domain expert, and since you are doing computational science, somewhat 
    multidisciplinary and know something about both the "computational" and the "science".

    We as the support team should be the expert in the "computational". Some of us where researchers in the past
    so have some domain knowledge about a the specific subfield we were working in, but there are simply too many
    scientific domains and subdomains to have full coverage of that in a central support team for a generic
    infrastructure.

    We do see that lots of crashes and performance problems with software are in fact caused by wrong use
    of the package!

    However, some users expect that we understand the science they are doing, find the errors in their model
    and run that on LUMI, preferably by the evening they submitted the ticket. If we could do that, then
    we could basically make a Ph.D that usually takes 4 years in 4 weeks and wouldn't need users anymore as it
    would be more fun to produce the science that our funding agencies expect ourselves.

-   The LUST help desk members know a lot about LUMI but cannot know or solve everything and
    may need to pass your problem to other instances, and in particular HPE or AMD.

    Debugging system software is not the task of the of the LUST. 
    Issues with compilers or libraries can only be solved by those instances that produce those compilers
    or libraries, and this takes time.

    We have a way of working that enables us to quickly let users test changes to software in the user software
    stack by making user installations relatively easy and reproducible using EasyBuild, but changing the 
    software installed in the system images - which includes the Cray programming environment - where changes 
    have an effect on how the system runs and can affect all users, are non-trivial and many of those changes
    can only be made during maintenance breaks.


### Beware of the XY-problem!

<figure markdown style="border: 1px solid #000">
  ![Beware of the XY-problem](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/TicketsXY.png){ loading=lazy }
</figure>

Partly quoting from [xyproblem.info](https://xyproblem.info): 
Users are often tempted to ask questions about the solution they have in mind and where they got
stuck, while it may actually be the wrong solution to the actual problem. As a result one can
waste a lot of time attempting to get the solution they have in mind to work, while at the end
it turns out that that solution does not work. It goes as follows:

1.  The user wants to do X.
2.  The user doesn't really know how to do X. However, they think that doing Y first would
    be a good step towards solving X.
3.  But the user doesn't really know how to do Y either and gets stuck there too.
4.  So the user contacts the help desk to help with solving problem Y.
5.  The help desk tries to help with solving Y, but is confused because Y seems a very strange and
    unusual problem to solve.
6.  Once Y is solved with the help of the help desk, the user is still stuck and cannot solve X yet.
7.  User contacts the help desk again for further help and it turns out that Y wasn't needed in the 
    first place as it is not part of a suitable solution for X.

Or as one of the colleagues of the author of these notes says: "Often the help desk knows the solution,
but doesn't know the problem so cannot give the solution."

To prevent this, you as a user has to be complete in your description:

1.  Give the broader problem and intent (so X), not just the small problem (Y) on which you got stuck.

2.  Promptly provide information when the help desk asks you, even if you think that information is
    irrelevant. The help desk team member may have a very different look on the problem and come up
    with a solution that you couldn't think of, and you may be too focused on the solution that you have
    in mind to see a better solution.

3.  Being complete also means that if you ruled out some solutions, share with the help desk why you ruled
    them out as it can help the help desk team member to understand what you really want.

After all, if your analysis of your problem was fully correct, you wouldn't need to ask for help, don't you?


## What support can we offer?

### Restrictions

<figure markdown style="border: 1px solid #000">
  ![help desk restrictions](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/HelpdeskRestrictions.png){ loading=lazy }
</figure>

Contrary to what you may be familiar with from your local Tier-2 system and support staff,
team members of the LUMI help desks have no elevated privileges. This holds for both the
LUST and LUMI-BE help desk.

As a result,

-   We cannot access user files.
    A specific person of the LUMI-BE help desk can access your project, scratch and flash folders
    if you make them part of the project. This requires a few steps and therefore is only done
    for a longer collaboration between a LUMI project and that help desk member.
    The LUST members don't do that.

-   Help desk team members cannot install or modify system packages or settings. 

    A good sysadmin usually wouldn't do so either. You are working on a multi-user system and you 
    have to take into account that any change that is beneficial for you, may have adverse
    effects for other users or for the system as a whole.

    E.g., installing additional software in the images takes away from the available memory on each
    node, slows down the system boot slightly, and can conflict with software that is installed through
    other ways.

-   The help desk cannot extend the walltime of jobs.

    Requests are never granted, even not if the extended wall time would still be within the limits of the
    partition. 

-   The LUST is in close contact with the sysadmins, but as the sysadmins are very busy people they will
    not promptly deal with any problem. Any problem though endangering the stability of the system gets a
    high priority.

-   The help desk does not monitor running jobs. Sysadmins monitor the general health of the system, but will 
    not try to pick out inefficient jobs unless the job does something that has a very negative effect on
    the system.


### What support can and cannot do

<figure markdown style="border: 1px solid #000">
  ![What support can and cannot do (1)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/HelpdeskCanCannot1.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![What support can and cannot do (2)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/HelpdeskCanCannot2.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![What support can and cannot do (3)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/HelpdeskCanCannot3.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![What support can and cannot do (4)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-106-Support/HelpdeskCanCannot4.png){ loading=lazy }
</figure>

<!-- GENERAL Only the general version as maintaining 2 versions together causes too much layout problems. -->
-   The LUST help desk does not replace a good introductory HPC course nor is it a 
    search engine for the documentation. L0 support is the responsibility of every user.

-   Resource allocators are responsible for the first steps in getting a project and userid on
    LUMI. EuroHPC projects the support is offered through CSC,
    the operator of LUMI, at lumi-customer-accounts@csc.fi, or by EuroHPC itself at
    access@eurohpc-ju.europa.eu if you have not yet been granted a project by them.

    Once your project is created and accepted (and the resource allocator can confirm that you
    properly accepted the invitation), support for account problems (in particular login problems) 
    moves to the LUST.

-   If you run out of block or file quota, the LUST can increase your quota within 
    [the limits specified in the LUMI documentation](https://docs.lumi-supercomputer.eu/storage/#lumi-network-file-system-disk-storage-areas).

    If you run out of billing units for compute or storage, only the instance that granted your project
    can help you, your resource allocator for local projects and access@eurohpc-ju.europa.eu 
    for EuroHPC projects (CSC EuroHPC support at lumi-customer-accounts@csc.fi cannot help you
    directly for project extensions and increase of billing units).

    Projects cannot be extended past one year unless the granting instance is willing to take a 
    charge on the annual budget for the remaining billing units.

-   The LUST cannot do much complete software installations but often can give useful advice and
    do some of the work.

    Note however that the LUST may not even be allowed to help you due to software license restrictions.
    Moreover, LUST has technically speaking a zone where they can install software on the system, but this
    is only done for software that the LUST can properly support across system updates 
    and that is of interest to a wide enough audience. 
    It is also not done for software where many users may want a specifically customised installation.
    Neither is it done for software that LUST cannot sufficiently test themselves.

-   The LUST can help with questions regarding compute and storage use.
    LUST provides L1 and basic L2 support. These are basically problems that can solved in hours rather than
    days or weeks. More advanced support has to come from other channels though,
    including support efforts from your local organisation, EuroHPC Centres of Excellence, 
    EPICURE, ...

-   The LUST can help with analysing the source of crashes or poor performance, with the emphasis on 
    "help" as they rarely have all the application knowledge required to dig deep.
    And it will still require a significant effort from your side also.

-   However, LUST is not a debugging service (though of course we do
    take responsibility for code that we developed).

-   The LUST has some resources for work on porting and optimising codes to/for AMD GPUs
    via porting calls and hackathons respectively. But we are not a general code porting
    and optimisation service. And even in the porting call projects, you are responsible 
    for doing the majority of the work, LUST only supports.

-   The LUST cannot do your science or solve your science problems though.


Remember:

**"Supercomputer support is there to 
support you in the computational aspects of your work 
related to the supercomputer
but not to take over your work."**

Any support will always be a collaboration where you may have to do most of the work.
Supercomputer support services are not a free replacement of a research software engineer
(the equivalent of the lab assistant that many experimental groups have).


## Links

-   LUMI web sites

    -   The [main LUMI web site](https://lumi-supercomputer.eu/) contains very general information about
        LUMI and also has a section in which the trainings organised by the LUST and some other trainings
        are announced. It is also the starting point to contact the LUST with your support questions via
        web forms. The web forms assure that we have the necessary information to start investigating your 
        issues.

        Note that when the support form asks for a project number, this is the project number on LUMI 
        (of the form 465XXXXXX for most projects) and not
        the project number used in LUMI-BE or EuroHPC, as the LUST does not know these numbers.

    -   The [LUMI documentation](https://docs.lumi-supercomputer.eu/)
        covers the LUMI system itself and includes topics such as how to get on the 
        system, where to place your files, how to start jobs, how to use the programming environment,
        how to install software, etc.

        This is your primary source of information when you are investigating if LUMI might be suitable
        for you, or once you have obtained a project on LUMI.

    -   The [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) contains
        an overview of software pre-installed on LUMI or for which we have install recipes to start from.
        For some software packages, it also contains additional information on how to use the software
        on LUMI.

-   These course notes also contain a
    [page with links into technical documentation](A01-Documentation.md)
    of the scheduler and the programming environments on LUMI, and links to the user documentation
    of some similar systems.

<!-- BELGIUM
-   Web sites in Belgium:

    -   The [EuroCC Belgium web site](https://www.enccb.be/) announced most local and LUST LUMI trainings
        in [the "Trainings" section](https://www.enccb.be/training)
        and also contains information on 
        [how to apply for compute time on LUMI via the Belgian share](https://www.enccb.be/GettingAccess).

    -   The [VSC web site](https://www.vscentrum.be/).
        Several [VSC trainings](https://www.vscentrum.be/vsctraining) are also relevant for (future) LUMI users!

        The VSC [Supercomputers for Starters](https://www.uantwerpen.be/en/research-facilities/calcua/training/) course
        lectured at UAntwerpen also covers several topics that are even more relevant to LUMI than to the
        Tier-2 systems of VSC and CÉCI. 
        [Full course notes are available](https://klust.github.io/SupercomputersForStarters/),
        so you can have a look at the material if you have no time to join the lectures (twice a year).

    -   The [CÉCI web site](https://www.ceci-hpc.be/).
        Several [CÉCI trainings](https://www.ceci-hpc.be/training.html) are also relevant for (future) LUMI users!
-->

