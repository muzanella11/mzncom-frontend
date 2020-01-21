local utils                         = import 'DronePipelineDefinition/functions/utils.libsonnet';
local events                        = import 'DronePipelineDefinition/variables/events.libsonnet';
local helper                        = import 'DronePipelineDefinition/pipelines/helper.libsonnet';

local Builds                        = import '.libsonnet/Builds.libsonnet';
local CodeSanitize                  = import '.libsonnet/CodeSanitize.libsonnet';
local Deploys                       = import '.libsonnet/Deploys.libsonnet';

local codeSanitize(params) = {
    kind: "pipeline",
    name: 'code-sanitize-%s' % params.projectName,
    clone: { disable: true },
    steps: [
        helper.gen(params.customGitClone),
        helper.gen(params.cs)
    ],
    trigger: { event: params.event, branch: params.branch },
};

local pipeline(params) = {
    kind: "pipeline",
    name: utils.generatePipelineName('%s' % [params.projectName],params.event,params.branch),
    clone: { disable: true },
    steps: [
      helper.gen(params.customGitClone),
      helper.gen(params.depedenciesBuild)
    ],
    trigger: if (params.event == 'tag' && params.tagRefs == null) then {event: params.event}
             else if (params.event == 'tag' && params.tagRefs != null) then {event: params.event, ref: params.tagRefs}
             else {event: params.event, branch: params.branch},
};

[
    codeSanitize(cs) for cs in CodeSanitize
] + [
    pipeline(build) for build in Builds
] + [
    k8s.gen(deploy) for deploy in Deploys
]
