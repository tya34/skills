param(
  [switch]$SkipExisting
)

$ErrorActionPreference = 'Stop'

$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
$SkillsDir = Join-Path $CodexHome 'skills'
$Installer = Join-Path $SkillsDir '.system/skill-installer/scripts/install-skill-from-github.py'

if (-not (Test-Path $Installer)) {
  throw "Codex skill installer not found: $Installer. Open Codex once, then retry."
}

function Install-SkillPath {
  param(
    [string]$Repo,
    [string]$Path,
    [string]$Name = '',
    [string]$Ref = 'main'
  )

  $destName = if ($Name) { $Name } elseif ($Path -eq '.') { '' } else { Split-Path $Path -Leaf }
  if (-not $destName) { throw "Root skill path requires -Name for $Repo" }
  $dest = Join-Path $SkillsDir $destName

  if ($SkipExisting -and (Test-Path $dest)) {
    Write-Host "Skip existing $destName"
    return
  }

  $args = @($Installer, '--repo', $Repo, '--ref', $Ref, '--path', $Path, '--method', 'download')
  if ($Name) { $args += @('--name', $Name) }
  Write-Host "Install $destName from $Repo/$Path"
  & python @args
  if ($LASTEXITCODE -ne 0) { throw "Install failed: $destName from $Repo/$Path" }
}

function Install-Many {
  param([string]$Repo, [string[]]$Paths, [string]$Ref = 'main')
  foreach ($p in $Paths) { Install-SkillPath -Repo $Repo -Path $p -Ref $Ref }
}

$blendops = @(
'bundles/skill-package/blendops',
'skills/acceptance-criteria-builder',
'skills/asset-fallback-strategy',
'skills/asset-library-organization-planner',
'skills/asset-license-checker',
'skills/asset-style-consistency-checker',
'skills/blender-asset-discovery-planner',
'skills/blender-brainstorming',
'skills/blender-checklist-driven-workflow',
'skills/blender-composition-camera-planner',
'skills/blender-lighting-material-planner',
'skills/blender-recipe-decomposer',
'skills/blender-scene-quality-checker',
'skills/blender-scope-boundary-enforcer',
'skills/blender-stop-condition-decider',
'skills/blender-troubleshooting',
'skills/blendops-help',
'skills/character-portrait-scene-planner',
'skills/cli-appendix-job-outline',
'skills/color-management-decision',
'skills/composition-quality-checker',
'skills/cycles-vs-eevee-decision',
'skills/environment-establishing-shot-planner',
'skills/glb-animation-handoff',
'skills/glb-mobile-performance-budget',
'skills/glb-web-handoff',
'skills/intent-to-3d-brief-writer',
'skills/interior-architectural-scene-planner',
'skills/lighting-quality-checker',
'skills/material-quality-checker',
'skills/non-blender-user-response-writer',
'skills/official-runtime-readiness-checker',
'skills/official-runtime-setup-guide',
'skills/output-format-decision',
'skills/pack-prerequisite-checker',
'skills/path-one-host-outline',
'skills/polycount-budget-checker',
'skills/pre-handoff-verification',
'skills/preview-report-template-writer',
'skills/product-grid-scene-planner',
'skills/product-hero-scene-planner',
'skills/recipe-fit-assessor',
'skills/render-export-evidence',
'skills/resolution-aspect-decision',
'skills/runtime-attempt-report-writer',
'skills/runtime-bridge-conflict-resolver',
'skills/runtime-path-picker',
'skills/three-fiber-component-shape-planner',
'skills/workflow-stage-router'
)
Install-Many 'ThanhNguyxnOrg/blendops' $blendops

$ccBlender = @(
'plugin/skills/animation-quality-gate',
'plugin/skills/atlas-uv-fitting',
'plugin/skills/blender-animation',
'plugin/skills/blender-cameras',
'plugin/skills/blender-export',
'plugin/skills/blender-lighting',
'plugin/skills/blender-materials',
'plugin/skills/blender-modeling',
'plugin/skills/blender-pro-workflow',
'plugin/skills/blender-rendering',
'plugin/skills/blender-skill-harmonizer',
'plugin/skills/blender-uv-texturing',
'plugin/skills/closed-surface-uv-coverage',
'plugin/skills/contour-to-mesh',
'plugin/skills/fit-repair-optimizer',
'plugin/skills/landmark-fit-repair',
'plugin/skills/mascot-logo-reconstruction',
'plugin/skills/multiview-constraint-solver',
'plugin/skills/multiview-fit-loop',
'plugin/skills/orbital-hud-motion',
'plugin/skills/orthographic-registration',
'plugin/skills/quality-refinement-autoloop',
'plugin/skills/reference-analysis-validator',
'plugin/skills/reference-look-calibration',
'plugin/skills/reference-to-3d',
'plugin/skills/source-part-segmentation',
'plugin/skills/text-to-blender',
'plugin/skills/texture-driven-mesh-fitting',
'plugin/skills/texture-state-animation',
'plugin/skills/wireframe-to-3d'
)
Install-Many 'RobLe3/cc-blender-skill' $ccBlender

$raBlender = @(
'skills/blender-animation-rigging',
'skills/blender-compositing-nodes',
'skills/blender-geometry-nodes',
'skills/blender-modeling-modifiers',
'skills/blender-physics-simulation',
'skills/blender-python-scripting',
'skills/blender-scene-rendering',
'skills/blender-shader-nodes'
)
Install-Many 'ra100/blender-claude-plugin' $raBlender 'master'

Install-SkillPath 'ProfRino/Blender-MCP-Assembly-Skill' '.' 'blender-mcp-assembly'
Install-SkillPath 'powerhouse90/Blender-Superskill' 'skills/blender-superskill'
Install-SkillPath 'jithinolickal/blender' 'skills/blender' 'blender-lightweight-codex'

$impertio = @(
'skills/aec-cross-tech/agents/aec-agents-workflow-orchestrator',
'skills/aec-cross-tech/core/aec-core-bim-workflows',
'skills/blender/agents/blender-agents-code-validator',
'skills/blender/agents/blender-agents-version-migrator',
'skills/blender/core/blender-core-api',
'skills/blender/core/blender-core-gpu',
'skills/blender/core/blender-core-runtime',
'skills/blender/core/blender-core-versions',
'skills/blender/errors/blender-errors-context',
'skills/blender/errors/blender-errors-data',
'skills/blender/errors/blender-errors-version',
'skills/blender/impl/blender-impl-addons',
'skills/blender/impl/blender-impl-animation',
'skills/blender/impl/blender-impl-automation',
'skills/blender/impl/blender-impl-mesh',
'skills/blender/impl/blender-impl-nodes',
'skills/blender/impl/blender-impl-operators',
'skills/blender/syntax/blender-syntax-addons',
'skills/blender/syntax/blender-syntax-animation',
'skills/blender/syntax/blender-syntax-data',
'skills/blender/syntax/blender-syntax-materials',
'skills/blender/syntax/blender-syntax-mesh',
'skills/blender/syntax/blender-syntax-modifiers',
'skills/blender/syntax/blender-syntax-nodes',
'skills/blender/syntax/blender-syntax-operators',
'skills/blender/syntax/blender-syntax-panels',
'skills/blender/syntax/blender-syntax-properties',
'skills/blender/syntax/blender-syntax-rendering',
'skills/bonsai/agents/bonsai-agents-ifc-validator',
'skills/bonsai/core/bonsai-core-architecture',
'skills/bonsai/errors/bonsai-errors-common',
'skills/bonsai/impl/bonsai-impl-bcf',
'skills/bonsai/impl/bonsai-impl-clash',
'skills/bonsai/impl/bonsai-impl-classification',
'skills/bonsai/impl/bonsai-impl-drawing',
'skills/bonsai/impl/bonsai-impl-modeling',
'skills/bonsai/impl/bonsai-impl-project',
'skills/bonsai/impl/bonsai-impl-qto',
'skills/bonsai/syntax/bonsai-syntax-elements',
'skills/bonsai/syntax/bonsai-syntax-geometry',
'skills/bonsai/syntax/bonsai-syntax-properties',
'skills/bonsai/syntax/bonsai-syntax-spatial',
'skills/ifcopenshell/agents/ifcos-agents-code-validator',
'skills/ifcopenshell/core/ifcos-core-concepts',
'skills/ifcopenshell/core/ifcos-core-runtime',
'skills/ifcopenshell/errors/ifcos-errors-patterns',
'skills/ifcopenshell/errors/ifcos-errors-performance',
'skills/ifcopenshell/errors/ifcos-errors-schema',
'skills/ifcopenshell/impl/ifcos-impl-cost',
'skills/ifcopenshell/impl/ifcos-impl-creation',
'skills/ifcopenshell/impl/ifcos-impl-geometry',
'skills/ifcopenshell/impl/ifcos-impl-materials',
'skills/ifcopenshell/impl/ifcos-impl-mep',
'skills/ifcopenshell/impl/ifcos-impl-profiles',
'skills/ifcopenshell/impl/ifcos-impl-relationships',
'skills/ifcopenshell/impl/ifcos-impl-sequence',
'skills/ifcopenshell/impl/ifcos-impl-validation',
'skills/ifcopenshell/syntax/ifcos-syntax-api',
'skills/ifcopenshell/syntax/ifcos-syntax-elements',
'skills/ifcopenshell/syntax/ifcos-syntax-fileio',
'skills/ifcopenshell/syntax/ifcos-syntax-util',
'skills/sverchok/agents/sverchok-agents-code-validator',
'skills/sverchok/core/sverchok-core-concepts',
'skills/sverchok/errors/sverchok-errors-common',
'skills/sverchok/impl/sverchok-impl-custom-nodes',
'skills/sverchok/impl/sverchok-impl-extensions',
'skills/sverchok/impl/sverchok-impl-ifcsverchok',
'skills/sverchok/impl/sverchok-impl-parametric',
'skills/sverchok/impl/sverchok-impl-topologic',
'skills/sverchok/syntax/sverchok-syntax-api',
'skills/sverchok/syntax/sverchok-syntax-data',
'skills/sverchok/syntax/sverchok-syntax-scripting',
'skills/sverchok/syntax/sverchok-syntax-sockets'
)
Install-Many 'Impertio-Studio/Blender-Bonsai-ifcOpenshell-Sverchok-Claude-Skill-Package' $impertio

Install-SkillPath 'wfy-op/codex-for-comsol-lumerical' 'lumerical-fdtd'
Install-SkillPath 'wfy-op/codex-for-comsol-lumerical' 'comsol-multiphysics' 'wfy-comsol-multiphysics'
Install-SkillPath 'Lex669/LumericalFDTD-skill' 'skills/LumericalFDTD'
Install-SkillPath 'svd-ai-lab/sim-plugin-comsol' 'src/sim_plugin_comsol/_skills/comsol' 'sim-plugin-comsol'
Install-SkillPath '2p1c/comsol-skills' 'skills/comsol' 'comsol-api-reference' 'master'
Install-SkillPath 'streetartist/comsol-skill' 'comsol-multiphysics'
Install-SkillPath 'Bian-M-X/comsol-photonic-waveguide-optics-skill' '.' 'comsol-photonic-waveguide-optics'
Install-SkillPath 'aikkkkko/comsol-grating-skill' '.' 'comsol-grating-skill' 'master'
Install-SkillPath 'leima-max/comsol-opto-simulation-skill' 'skills/comsol-opto-simulation'
Install-SkillPath 'xianlinyue162-beep/comsol-phononic-modeling-skill' '.' 'comsol-phononic-modeling'

Write-Host 'Done. Restart Codex to pick up new skills.'
