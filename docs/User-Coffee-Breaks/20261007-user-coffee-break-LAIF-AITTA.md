# The LUMI AI Software Environment

**Presenters:** Marlon Tobaben and Mitja Sainio (CSC/LUMI AI Factory)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20261007-user-coffee-break-LAIF-AITTA.mp4" controls="controls"></video>

-   [Slides](https://462000265.lumidata.eu/user-coffee-breaks/files/20261007-user-coffee-break-LAIF-AITTA.pdf)


Q&A

1.  Does Aitta plan on offering api batch inference for larger
    workloads/benchmarks? Like [OpenAI Batch API](https://developers.openai.com/api/docs/guides/batch)
    or [Claude Platform Docs: Batch processing](https://platform.claude.com/docs/en/build-with-claude/batch-processing).

     -   (LP) We will consider it, but as I said during the presentation, if you really have a large amount of data for extensive batch inference, it is probably better (and cheaper) to use vLLM in offline mode to do it directly on LUMI
 
2.  What about the models - you just said that its some select models. How can I use it for my own? For example - for generating rollouts of RL workflow

    -   (LP) Aitta does not support running your own models.

    -   You always have an option to host your own model via vLLM, but keep in mind that you need to take security into account and cannot share your own credentials with others.

    -   See: [LLM chapter in the LUMI AI Guide](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/10-LLM-inference)

    -   (LP) Our LUMI AI Factory colleagues at IT4I are also working on bringing their [EXA4MIND inference service](https://exa4mind.eu/) to LUMI, which allows you to run custom models using your own allocations, so that will be also an option for you once it is available (and we will add it to the [AI Inference](https://docs.lumi-supercomputer.eu/laif/inference/) section of the LUMI AI Factory Documentation. A difference to Aitta is that all models run strictly only for your project, so you don't share with other users, so you get them entirely for yourself but also pay the full price for running it.

3.  Which inference engine and quantization are these models using?

    -   vLLM

    -   quantization: No currently, potentially looking into it.
 
4.  Why not hosting some models centrally that are preloaded and are not under subject of the slurm cluster to increase the efficiency? Because one pool of hardware for 1 user/few users is computationally not the most efficient way. Also many models improve when the concurrency increases. A gateway like [LiteLLM](https://litellm.ai) could take care of billing/security/etc. 

    -   LUMI is not a cloud solution. Everything goes via Slurm jobs. We can only set aside very limited capacity permanently for this service.

    -   To clarify: Users are sharing the models, so multiple users can use the same AITTA worker serving the same model. This is the reason why we expect the billing to be much cheaper than running your own models.
    
    It still is an interesting approach to bill through tokens -> GPU hours, and not bill straight tokens

    -   (LP) We have decided to do it this way for now because GPU-hours is the currently established way you "pay" for your LUMI usage. Introducing an additional token unit would likely add a lot of overhead: Any application would need to justify both (or either) GPU-hours for normal LUMI jobs and tokens for Aitta. Especially for EuroHPC allocations that would require changes on their side to allow applying for this. Additionally, all LUMI access portals would need to track both units. Furthermore, some models are more expensive to run than others, so having one token unit for all would likely not be feasible either.
    
5.  Do you have some more information about what types of data that are safe to submit to the models? (Licensed data, etc.)

    -   Please refer to the [LUMI Terms of Use](https://lumi-supercomputer.eu/termsandpolicies/) and the [AITTA terms of use](https://aitta.csc.fi/terms-of-use)

6.  You said you provide free access to startups. Do they have to be located in EU? Is Switzerland included?

    -   Switzerland included, see the [LUMI AI Factory Pricing and eligibility page](https://lumi-ai-factory.eu/pricing-and-eligibility/)

    -   Feel free to contact our business colleagues via the [LUMI AI Factory contact form](https://lumi-ai-factory.eu/contact-us/)

    Thank you! For how long do you plan to offer this service for startups?
    
    -   Current funding is still for roughly a year, but this will quite likely continue. Note that this is not only limited to LUMI, but most EU countries have their own AI Factory like Spain, Germany, France... So not only LUMI countries.

7. What about Aitta not as an inference utility but as a teaching theatre for LLM-service engineering (hardware resources + models + jobs logistics)?

    -   (LP) If you get a LUMI project for teaching use, you can use Aitta with it. But please keep in mind the limitations with regards to availability. E.g., there is no guarantee that the service would be available at any particular time (e.g. during a course exercise session). Also this would require that all users have a valid account that is added to the corresponding LUMI project so they can create their own access token, since tokens are personal and account sharing (=token sharing) is not permitted by the LUMI ToS.
  
        However, depending on your use case, you could potentially get a LUMI robot account and set up your own client in front of the API that mediates access for you students, i.e., your students would sent their requests to your client using your own authentication scheme, and that relays it to Aitta. However, you are then still bound by the [LUMI ToS](https://lumi-supercomputer.eu/termsandpolicies/) and need to ensure that you know everyone using your service and ensure that you abide by export restrictions, etc.

8.  If a token can live for 90 days, does this mean that the slurm job in the back also lives for 90 days?

    -   No, workers are running more something like 4 h, so you would get new workers.

    -   (MJ) Even though the slurm job is triggered by a user, it's not tied to the user's account and every worker answers requests from all users. 

9.  What about retention and logging? Are the conte4nt of the chat stored, and who can get access? And the same for documents for embeddings etc. non published research etc.

    -   (LP) Contents of chats are not stored (although they temporarily live in an internal database for communication while the request is in flight).

10. Can I use it with an AI-agent like Opencode...

    -   Yes, the LUMI AI Agent Environment has AITTA by default by selecting AITTA as a model provider.

    -   See a link [Agent Environments in the LUMI Documentation](https://docs.lumi-supercomputer.eu/laif/software/agent-infrastructure/#agent-environment) (You will need to change the provider to AITTA!)

11. Is the User Interface you showed a proprietary solution or based on an existing open-source AI platform / user interface ?

    - (MJ) It is based on Gradio, we're planning to release the code as open source soon.

12. Do you have a plan for future models? 

    -   Yes, we are constantly extending the pool. Feel free to suggest at the  
        [user support contact form of the LUMI AI Factory](https://lumi-ai-factory.eu/user-support/).

13.  Will you also host bigger models like GLM, KIMI?

    -   We are looking at this, but note that not every large model is feasible to run for many users on LUMI. E.g., KIMI K3 is very expensive model and needs emulation for the precision to the best of my knowledge. 

14. Can I generate multiple APIs in one project and use them at same time (Clarification: I mean generating multiple APIs for different uses. so if one is leaked, not need to replacing all others )?

    -   (LP) You can get a different token for the same project by pressing the "Regenerate" button on the page that displays your token. However, since all token grant equivalent access to all endpoints (currently), there is no benefit to having multiple tokens, as any one that gets leaked grants full access. The only benefit would be if you want to have the ability to shut down a particular client by revoking its specific token. 

15. Is it possible to limit the token (or GPU hours) consumption by setting a Maximum amount for a specific API?

    - (MJ) Not right now.

16. How does the billing works for large models, that don't fit on one node? Does the billing depend on the number of users a model is currently being used.

    -   (MJ) The billing is based only on the number of tokens used. Once it's taken into use, the prices (GPU hours per million tokens) will be viewable from the API. The price is set per-model, with models requiring larger resources typically being more expensive.

17. Do you plan to host newer, larger models from EU providers, such as Aleph Alpha’s Kolibri-1 and Mistral Large 4 (Le Chonk), once its weights are released later this month? These finally seem usable.

    -   (MJ) In general yes, the selection of models is being extended all the time. Cannot tell about the particular models yet.

18. What about KV caching for models hosted on Aitta?

    -   (MJ) We use vLLM as inference engine, which implements KV caching.

19. Can somebody upload datasets and query the model, save and download the answers? Are there size limitations to the size of datasets to upload and answers to download?

    -   (MJ) Aitta does not provide such a functionality but it can be implemented on the client side.

20. If I don't currently have an active LUMI project, but would be interested in AITTA access, what type of project should I apply for? "EuroHPC Playground Access to AI factories"? And can I just specify that I want to use e.g. Gemma4 through AITTA in the application? 

    -   Yes, that is possible. If you are elibigile. 

21. Is the webchat with a model free and does not consume GPU hours from a project allocation on LUMI?
    
    -   (MJ) Once the billing is taken into use, also the usage through the web interface will be billed normally (based on the number of tokens, billed from the LUMI project that you selected on login). Such interactions typically consume a tiny amount of resources though.

    So right now it is free but slow, and in the future will be billed, right?
    
    -   (MJ) Billing will be taken into use very soon (planned within the next 2 weeks). Right now it's free. The performance will not be affected by the change.

22. Are you planning to support also high-end open weight models in future, e.g., GLM 5.3 Flash, Deepseek v4.x models, or the just announced European Mistral Large 4 (Le Chonk) when it becomes available? Here quantization might be required to get the resource usage realistic enough to run with the still limited resources available to inference. It would be great to have at least one high end LLM available.
   
   - We will share this within the AITTA team.

23. I have an active project on LUMI. You mentioned that it’s possible to spin up our own vLLM instance. Is this possible with Slurm, and is inbound and outbound internet connectivity available?

    - (MJ) Yes, see https://docs.csc.fi/support/tutorials/ml-llm/#inference-with-vllm. Internet connectivity is possible with an SSH tunnel, but note that according to the LUMI terms of service sharing the tunnel with other users is forbidden. (This is about running an own slurm job with vLLM, *not* using Aitta.)


24. Do the models have internet access? 

    - (MJ) No. Aitta provides only the language models, tools (like internet access) can be implemented on the client side.

25. how about ssh forwarding and use api in my vs code in local computer?

    - API of AITTA is accessible without that as it is based on web protocols.

26. Can you come up with a solution for setting a maximum token limit for a specific API? We currently need to provide some students with access to LLMs for their projects, but managing and limiting their token consumption is a concern.

    -   (LP) This is not currently possible but we will take this into internal discussion and see what would be the best solution for this.

27. How to revoke an access key?

    -   You can revoke your tokens at the user profile page.

28. Would it be possible to show the currently available list of model without login? (I currently still have an expired LUMI project, so I was able to log in, but without this, one would not know which models are available without applying for a project. Re answer to question 20.)

    -   At the moment UI doesn't provide that information, but you can use the `/model` endpoint to fetch the models without authentication.

    -   (LP) But we were planning on adding a public catalogue list that shows the list from the `/model` endpoint.

    -   (LP) I think I misunderstood this a bit during my answer in the zoom session. There I replied to seeing models that are _currently running_  instead of available via Aitta.



