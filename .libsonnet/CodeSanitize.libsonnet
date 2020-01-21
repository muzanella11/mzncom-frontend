local events    = import '../DronePipelineDefinition/variables/events.libsonnet';

[
    {
        projectName: 'drone',
        event: events.codeSanitize.event,
        branch: events.codeSanitize.branch,

        customGitClone: {
            commands: [
                'git clone -b $DRONE_BRANCH --single-branch --depth 1 https://github.com/muzanella11/DronePipelineDefinition.git .',
                'git checkout -b $DRONE_COMMIT'
            ],
            envVars: null,
            image: 'alpine/git',
            event: events.codeSanitize.event,
            branch: events.codeSanitize.branch,
            stepName: 'git-clone',
            projectName: 'drone',
            tagRefs: null
        },

        cs: {
            commands: [
                'yarn install',
                'yarn test'
            ],
            envVars: null,
            image: 'travlrdev/composer-node',
            event: events.codeSanitize.event,
            branch: events.codeSanitize.branch,
            stepName: 'codeSanitize',
            projectName: 'drone',
        },
    },
]
