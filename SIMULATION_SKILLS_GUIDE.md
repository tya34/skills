# Simulation Skills Guide

这份说明对应 `install-codex-simulation-skills.ps1` 安装的组合。

## Blender

推荐组合：

- `blendops` 系列：总控、流程、安全、证据、质量门、资产许可、输出格式、运行时 readiness、troubleshooting。
- `cc-blender-skill` 系列：具体 Blender 任务执行，包括建模、材质、灯光、相机、渲染、动画、UV、导出、参考图到 3D、线框到 3D、质量自动修复。
- `ra100/blender-claude-plugin` 系列：Blender 5.x 专家参考，包括 Geometry Nodes、Shader Nodes、Compositing、Python scripting、Rigging、Modifiers、Physics、Rendering。
- `blender-mcp-assembly`：MCP 场景装配约束，适合减少几何尺寸、旋转、重叠、装配失控问题。
- `blender-superskill`：参考优先建模、硬表面、建筑/道具、迭代修复。
- `blender-lightweight-codex`：轻量 Codex/Claude/Cursor 兼容 Blender skill。
- Impertio AEC/BIM/IFC/Sverchok 系列：Bonsai、IfcOpenShell、Sverchok、BIM workflow、IFC 校验、参数化几何、建筑/工程数据流。

使用建议：

- 普通 Blender 生成：优先触发 `blendops` + `text-to-blender` / `blender-modeling` / `blender-materials` / `blender-rendering`。
- 参考图建模：加 `reference-to-3d`、`reference-analysis-validator`、`fit-repair-optimizer`。
- Geometry Nodes / Shader Nodes：加 `blender-geometry-nodes` 或 `blender-shader-nodes`。
- BIM / IFC / Bonsai：只在需要 AEC/BIM 时触发 Impertio 那组，避免无关上下文过多。
- MCP 自动化：先让 `official-runtime-readiness-checker` 或 `runtime-path-picker` 走 readiness，再运行 Blender Python。

## Ansys Lumerical FDTD

推荐组合：

- `lumerical-fdtd`：来自 `wfy-op/codex-for-comsol-lumerical`，负责连接探测、`lumapi`、CLI fallback、环境规范化、probe、失败分类。
- `LumericalFDTD`：来自 `Lex669/LumericalFDTD-skill`，负责实际 FDTD 建模流程、脚本模板、`.fsp` / `.npz` / `.png` 产物检查、常见 API 坑、分析脚本和报告。

使用建议：

- 第一次在某台机器用 FDTD：先用 `lumerical-fdtd` 做 dry-run / probe。
- 真正搭模型：再加载 `LumericalFDTD` 的模板和 common-errors。
- 需要 CLI fallback：让 `lumerical-fdtd` 先判定 `lumapi`、license、session、`fdtd-solutions` 哪一层失败。
- 删除或覆盖旧 `.fsp`、`.npz`、`.png` 前必须确认。

## COMSOL Multiphysics

推荐组合：

- `wfy-comsol-multiphysics`：来自 `wfy-op/codex-for-comsol-lumerical`，负责路径探测、`comsolbatch` / `comsolcompile`、Java API、Python `mph`、probe 和失败分类。
- `sim-plugin-comsol`：重型 live session / shared Desktop / `.mph` inspection / audit trail 驱动层。
- `comsol-api-reference`：来自 `2p1c/comsol-skills`，适合查 COMSOL API、tag、selection、mesh、solver、evaluation 的常见坑。
- `comsol-multiphysics`：来自 `streetartist/comsol-skill`，适合从零创建 electrostatics、heat transfer、electrothermal 等模板模型。
- `comsol-photonic-waveguide-optics`：集成光子波导、SOI、coupler、MMI、ring、Bragg、grating coupler、MZI 等波导光学工作流。
- `comsol-grating-skill`：2D 矩形光栅 Wave Optics TE 衍射效率专项。
- `comsol-opto-simulation`：光电探测器、吸收、光生载流子、半导体 I-V、热电耦合、responsivity / EQE 等。
- `comsol-phononic-modeling`：声子晶体、声学超材料、周期边界、Bloch/Floquet、模态追踪。

使用建议：

- 第一次接 COMSOL：优先 `wfy-comsol-multiphysics` dry-run，不修改模型。
- 需要 live Desktop 或 `.mph` 交互检查：再启用 `sim-plugin-comsol`。
- API 写法不确定：查 `comsol-api-reference`。
- 从零建模型：用 `comsol-multiphysics` 模板层。
- 专项物理问题：只加载对应专项 skill，避免把光栅、光电探测器、声子晶体规则混在一起。

## 安全策略

- skill 目录只保存 skill 本身，不保存项目模型、仿真输出和 license 信息。
- 每个 solver 先 probe，再执行真实任务。
- 自动化脚本生成在项目目录下，日志和结果也放项目目录。
- 不在没有确认的情况下覆盖用户已有 `.blend`、`.fsp`、`.mph` 或仿真结果。
- 对上游仓库保持警觉：安装前可重新阅读对应 `SKILL.md`，确认没有新增不合适的 install hook 或脚本行为。
