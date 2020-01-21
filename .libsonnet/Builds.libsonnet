local events    = import '../DronePipelineDefinition/variables/events.libsonnet';

[
    //development pipeline
    {
        projectName: 'drone',
        event: events.dev.event,
        branch: events.dev.branch,
        tagRefs: null,

        customGitClone: {
            commands: [
                'git clone -b $DRONE_BRANCH --single-branch --depth 1 https://github.com/muzanella11/DronePipelineDefinition.git .',
                'git checkout -b $DRONE_COMMIT'
            ],
            envVars: null,
            image: 'alpine/git',
            event: events.dev.event,
            branch: events.dev.branch,
            stepName: 'git-clone',
            projectName: 'drone-dev',
            tagRefs: null
        },

        depedenciesBuild: {
            commands: [
                'yarn install --ignore-engines --production=false',
                'yarn build'
            ],
            envVars: {},
            image: 'travlrdev/composer-node',
            event: events.dev.event,
            branch: events.dev.branch,
            stepName: 'buildDepedencies',
            projectName: 'drone-dev',
            tagRefs: null
        }

    },

    //staging pipeline
    {
        projectName: 'drone',
        event: events.stg.event,
        branch: events.stg.branch,
        tagRefs: null,

        customGitClone: {
            commands: [
                'git clone -b $DRONE_BRANCH --single-branch --depth 1 https://github.com/muzanella11/DronePipelineDefinition.git .',
                'git checkout -b $DRONE_COMMIT'
            ],
            envVars: null,
            image: 'alpine/git',
            event: events.stg.event,
            branch: events.stg.branch,
            stepName: 'git-clone',
            projectName: 'drone-stg',
            tagRefs: null
        },

        depedenciesBuild: {
            commands: [
                'yarn install --ignore-engines --production=false',
                'yarn build'
            ],
            envVars: {},
            image: 'travlrdev/composer-node',
            event: events.stg.event,
            branch: events.stg.branch,
            stepName: 'buildDepedencies',
            projectName: 'drone-stg',
            tagRefs: null
        },

    },

    //production pipeline
    {
        projectName: 'drone',
        event: events.prd.event,
        branch: events.prd.branch,
        tagRefs: null,

        customGitClone: {
            commands: [
                'git clone -b master --single-branch --depth 1 https://github.com/muzanella11/DronePipelineDefinition.git .',
                'git checkout -b $DRONE_COMMIT'
            ],
            envVars: null,
            image: 'alpine/git',
            event: events.prd.event,
            branch: events.prd.branch,
            stepName: 'git-clone',
            projectName: 'drone-prd',
            tagRefs: null
        },

        depedenciesBuild: {
            commands: [
                'yarn install --ignore-engines --production=false',
                'yarn build'
            ],
            envVars: {},
            image: 'travlrdev/composer-node',
            event: events.prd.event,
            branch: events.prd.branch,
            stepName: 'buildDepedencies',
            projectName: 'drone-prd',
            tagRefs: null
        },

    },
]
