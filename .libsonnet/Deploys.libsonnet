local events    = import '../DronePipelineDefinition/variables/events.libsonnet';
local utils     = import '../DronePipelineDefinition/functions/utils.libsonnet';

[
    //development pipeline
    {
        projectName: 'deploy-drone-dev',
        event: events.dev.event,
        branch: events.dev.branch,
        tag: events.dev.tags[1],
        namespace: 'development',
        deployment: 'drone',
        containers: ['drone'],
        ecrRepoName: 'drone',
        tagRefs: null,
        uat: 'no',
        depends_on: [utils.generatePipelineName('drone',self.event,self.branch)]
    },

    //staging pipeline
    {
        projectName: 'deploy-drone-stg',
        event: events.stg.event,
        branch: events.stg.branch,
        tag: events.stg.tags[1],
        namespace: 'staging',
        deployment: 'drone',
        containers: ['drone'],
        ecrRepoName: 'drone',
        tagRefs: null,
        uat: 'no',
        depends_on: [utils.generatePipelineName('drone',self.event,self.branch)]
    },

    //production pipeline
    {
        projectName: 'deploy-drone-prd',
        event: events.prd.event,
        branch: events.prd.branch,
        tag: events.prd.tags[1],
        namespace: 'production',
        deployment: 'drone',
        containers: ['drone'],
        ecrRepoName: 'drone',
        tagRefs: null,
        uat: 'no',
        depends_on: [utils.generatePipelineName('drone',self.event,self.branch)]
    }
]
