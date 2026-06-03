# Codex Simulation Skills

这是我为 Blender、Ansys Lumerical FDTD 和 COMSOL Multiphysics 整理的一套 Codex skill 组合安装仓库。

本仓库不是把所有上游 skill 重新打包成一个大包，而是记录一套可复现、可审计的安装组合：每个 skill 仍从原始 GitHub 仓库安装，便于后续获取上游修复，也避免把商业软件相关输出、许可证信息或大型仿真文件误提交进来。

## 本机已安装结果

安装日期：2026-06-04

本机 Codex skills 目录：`C:\Users\tya\.codex\skills`

本次安装完成：173 个非系统 skill。

核心分组：

- Blender：工作流治理、场景生成、材质、灯光、相机、渲染、动画、Geometry Nodes、Shader Nodes、Python scripting、MCP 装配、参考图到 3D、BIM/AEC/IFC/Bonsai/Sverchok。
- Lumerical FDTD：Ansys Lumerical FDTD 连接探测、`lumapi`、CLI fallback、FDTD 建模、监视器、Qanalysis、far-field、材料数据、脚本模板、结果导出。
- COMSOL：COMSOL 路径探测、`comsolbatch` / `comsolcompile`、Java API、Python `mph`、live session、`.mph` 检查、结果导出、API 坑位参考、光子波导、光栅、光电探测器、声子/周期结构。

## 一键安装

在另一台设备上，先确保 Codex 已经运行过一次，并且系统 skill-installer 存在。

Windows PowerShell：

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install-codex-simulation-skills.ps1
```

如果某些 skill 已经安装过，可以用：

```powershell
.\install-codex-simulation-skills.ps1 -SkipExisting
```

安装完成后重启 Codex，让新 skills 被加载。

## 安全建议

这些 skill 本身主要是说明、模板和工作流，但它们会引导 Codex 调用 Blender Python、Lumerical FDTD、COMSOL Java API、Python `mph` 或本地 solver CLI。这些运行时没有真正沙箱，所以建议：

- 在隔离项目目录或 VM 中运行 Blender / COMSOL / Lumerical 自动化。
- 先做 dry-run / probe，再跑真实模型。
- 不要让 skill 修改商业软件安装目录。
- 不要把 license server、token、私有模型、商业数据写入 Git 或日志。
- 删除或覆盖 `.blend`、`.fsp`、`.mph`、`.npz`、`.png` 等结果前必须显式确认。
- Lumerical / COMSOL 的 probe 输出应保存在当前项目的 `solver_probe_out/` 或类似目录，而不是 skill 目录里。

## 主要来源

- https://github.com/ThanhNguyxnOrg/blendops
- https://github.com/RobLe3/cc-blender-skill
- https://github.com/ra100/blender-claude-plugin
- https://github.com/Impertio-Studio/Blender-Bonsai-ifcOpenshell-Sverchok-Claude-Skill-Package
- https://github.com/ProfRino/Blender-MCP-Assembly-Skill
- https://github.com/powerhouse90/Blender-Superskill
- https://github.com/jithinolickal/blender
- https://github.com/wfy-op/codex-for-comsol-lumerical
- https://github.com/Lex669/LumericalFDTD-skill
- https://github.com/svd-ai-lab/sim-plugin-comsol
- https://github.com/2p1c/comsol-skills
- https://github.com/streetartist/comsol-skill
- https://github.com/Bian-M-X/comsol-photonic-waveguide-optics-skill
- https://github.com/aikkkkko/comsol-grating-skill
- https://github.com/leima-max/comsol-opto-simulation-skill
- https://github.com/xianlinyue162-beep/comsol-phononic-modeling-skill
