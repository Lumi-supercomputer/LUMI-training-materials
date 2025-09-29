# SmartSim: Enhancing numerical workflows with AI components

*Presenters:* Alessandro Rigazzi (HPE)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20250924-user-coffee-break-SmartSim.mp4" controls="controls"></video>


## Links from the presentation

-   E-mail contact: ClayLabs@hpe.com

-   [SmartSim documentation](https://www.craylabs.org)

-   [SmartSim Repository](https://github.com/CrayLabs/SmartSim), including a docker container with tutorials.

-   [SmartRedis repository](https://github.com/CrayLabs/SmartRedis)

-   [SmartSim case studies](https://github.com/CrayLabs/SmartSim-Zoo)

-   There is also a [SmartSim Slack workspace](https://join.slack.com/t/craylabs/shared_invite/zt-nw3ag5z5-5PS4tIXBfufu1bIvvr71UA), 
    linked also from the repo.


## Q&A

1.  How can I use SmartSim in finetuing a LLM?

    -   _Alessandro_: this is quite an open question, and the answer depends on what type of finetuning you would like to perform. 
        SmartSim could be used to stage data in memory and access it through a SmartRedis-based data loader. 
        If the finetuning aims at using numeric data, then SmartSim can make the data available for the LLM to train on, 
        sending it from the running simulation to the orchestrator. 
        Please do not hesitate to send a mail to 
        [our support-dedicated email address](mailto:craylabs@hpe.com?subject=&#91;LUMI%20Coffee%20Break%20question&#93;%20) 
        if you have other questions.

