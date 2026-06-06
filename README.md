# Codex Simulation Skills

这是一个面向 Codex 的 simulation skills 组合安装仓库，用来复现一套 Blender、AEC/BIM/IFC、Ansys Lumerical FDTD 和 COMSOL Multiphysics 相关 skill 的安装方案。

本仓库不把所有上游 skill 重新打包成一个大包，而是记录一套可复现、可审计的安装组合：每个 skill 仍从原始 GitHub 仓库安装，便于后续获取上游修复，也避免把商业软件输出、许可证信息或大型仿真文件误提交进来。

## 当前安装纪要

安装复核日期：2026-06-06

当前机器：`C:\Users\tiany`

Codex skills 目录：`C:\Users\tiany\.codex\skills`

本组合安装完成：173 个非系统 skill。

最终复核：

```text
Checked 28 skills
All checked skills have SKILL.md
Total non-system skill dirs: 173
```

## 全局通用 Git 安装方法

本仓库统一使用 Git 安装上游 skills。Git 方法适合小仓库和大型仓库，也适合安装途中断后用 `-SkipExisting` 继续补装。

### 1. 准备 Git

任选一种即可：

- 安装 Git for Windows，并确保 `git` 在 PowerShell 中可用。
- 安装 GitHub Desktop。安装脚本会自动寻找 GitHub Desktop 自带的 Git。

GitHub Desktop 自带 Git 的常见路径：

```text
C:\Users\<user>\AppData\Local\GitHubDesktop\app-*\resources\app\git\cmd\git.exe
```

手动检查 GitHub Desktop 自带 Git：

```powershell
Get-ChildItem "$env:LOCALAPPDATA\GitHubDesktop" -Recurse -Filter git.exe |
  Select-Object -First 10 FullName
```

### 2. 准备 Codex skill-installer

先确保 Codex 已运行过一次，并且系统 skill-installer 已存在：

```text
%USERPROFILE%\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py
```

### 3. 一键安装或续装

在本仓库根目录运行：

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\install-codex-simulation-skills.ps1 -SkipExisting
```

脚本固定使用 `skill-installer --method git`。如果某些 skill 已经安装过，`-SkipExisting` 会跳过已有目录，继续安装缺失项。

安装完成后重启 Codex，让新 skills 被加载。

### 4. 单个 skill 手动安装模板

需要单独补装某个 skill 时，可以直接调用系统安装器：

```powershell
$installer = Join-Path $HOME '.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py'

python $installer `
  --repo owner/repo `
  --ref main `
  --path path/to/skill `
  --name optional-skill-name `
  --method git
```

如果目标目录名应直接取路径最后一段，可以省略 `--name`。

示例：

```powershell
$installer = Join-Path $HOME '.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py'

python $installer `
  --repo wfy-op/codex-for-comsol-lumerical `
  --ref main `
  --path comsol-multiphysics `
  --name wfy-comsol-multiphysics `
  --method git
```

验证安装：

```powershell
Test-Path "$HOME\.codex\skills\wfy-comsol-multiphysics\SKILL.md"
```

## 为什么统一使用 Git

本组合涉及多个上游仓库，其中部分仿真仓库体积较大。Git 安装方式更适合：

- 避免完整仓库 zip 下载过程中的断流。
- 避免递归调用 GitHub Contents API 导致匿名 API 限流。
- 支持中断后重跑，并通过 `-SkipExisting` 继续补装。
- 复用 GitHub Desktop 或 Git for Windows 的凭据和网络配置。

本仓库不再维护其他安装路径说明。遇到安装问题时，优先修复本机 Git 可用性，再重新运行安装脚本。

## Skill 组合总览

### Blender / 3D

- `blendops` 系列：工作流治理、brief、验收标准、资产许可、运行时 readiness、输出证据、质量门和故障排查。
- `cc-blender-skill` 系列：建模、材质、灯光、相机、渲染、动画、UV、导出、参考图到 3D、线框到 3D、质量修复。
- `ra100/blender-claude-plugin` 系列：Blender 5.x Geometry Nodes、Shader Nodes、Compositing、Python scripting、Rigging、Modifiers、Physics 和 Rendering。
- `blender-mcp-assembly`：MCP 场景装配约束，适合减少几何尺寸、旋转、重叠、装配失控问题。
- `blender-superskill`：参考优先建模、硬表面、建筑/道具、迭代修复。
- `blender-lightweight-codex`：轻量 Codex/Claude/Cursor 兼容 Blender skill。

### AEC / BIM / IFC / Bonsai / Sverchok

- AEC 总控：跨 Blender、IfcOpenShell、Bonsai、Sverchok 的 BIM 工作流编排。
- Bonsai：IFC 项目、空间层级、元素、属性集、分类、图纸、QTO、BCF 和 clash 工作流。
- IfcOpenShell：IFC 创建、几何、材料、关系、成本、MEP、剖面、序列、验证、文件 IO 和 API 语法。
- Sverchok：参数化几何、custom nodes、extensions、IfcSverchok、Topologic 和 socket/data/scripting 语法。

### Ansys Lumerical FDTD

- `lumerical-fdtd`：来自 `wfy-op/codex-for-comsol-lumerical`，负责连接探测、`lumapi`、CLI fallback、环境规范化、probe 和失败分类。
- `LumericalFDTD`：来自 `Lex669/LumericalFDTD-skill`，负责实际 FDTD 建模流程、脚本模板、`.fsp` / `.npz` / `.png` 产物检查、常见 API 坑、分析脚本和报告。

### COMSOL Multiphysics

- `wfy-comsol-multiphysics`：路径探测、`comsolbatch` / `comsolcompile`、Java API、Python `mph`、probe 和失败分类。
- `sim-plugin-comsol`：重型 live session / shared Desktop / `.mph` inspection / audit trail 驱动层。
- `comsol-api-reference`：COMSOL API、tag、selection、mesh、solver、evaluation 常见坑参考。
- `comsol-multiphysics`：从零创建 electrostatics、heat transfer、electrothermal 等模板模型。
- `comsol-photonic-waveguide-optics`：集成光子波导、SOI、coupler、MMI、ring、Bragg、grating coupler、MZI 等波导光学工作流。
- `comsol-grating-skill`：2D 矩形光栅 Wave Optics TE 衍射效率专项。
- `comsol-opto-simulation`：光电探测器、吸收、光生载流子、半导体 I-V、热电耦合、responsivity / EQE 等。
- `comsol-phononic-modeling`：声子晶体、声学超材料、周期边界、Bloch/Floquet、模态追踪。

## 补装清单

本次在已有 Blender/AEC skill 基础上，新增或补齐了以下关键项：

- IfcOpenShell sequence / validation / syntax 系列。
- Sverchok agents / core / errors / impl / syntax 系列。
- `lumerical-fdtd`
- `wfy-comsol-multiphysics`
- `LumericalFDTD`
- `sim-plugin-comsol`
- `comsol-api-reference`
- `comsol-multiphysics`
- `comsol-photonic-waveguide-optics`
- `comsol-grating-skill`
- `comsol-opto-simulation`
- `comsol-phononic-modeling`

## 故障排查

### `git` 找不到

安装 Git for Windows 或 GitHub Desktop。脚本会自动寻找 GitHub Desktop 自带 Git；如果仍失败，可手动检查：

```powershell
Get-ChildItem "$env:LOCALAPPDATA\GitHubDesktop" -Recurse -Filter git.exe |
  Select-Object -First 10 FullName
```

### 已安装一部分后中断

直接重跑：

```powershell
.\install-codex-simulation-skills.ps1 -SkipExisting
```

脚本会跳过已有目录。每个有效 skill 目录必须包含 `SKILL.md`。

### GitHub 网络或凭据问题

先确认普通 Git 命令可用：

```powershell
git --version
git ls-remote https://github.com/tya34/skills.git
```

如果访问私有仓库或遇到认证问题，先在 GitHub Desktop 或 Git Credential Manager 中完成登录，再重新运行安装脚本。

## 安全建议

这些 skill 本身主要是说明、模板和工作流，但会引导 Codex 调用 Blender Python、Lumerical FDTD、COMSOL Java API、Python `mph` 或本地 solver CLI。这些运行时没有真正沙箱，所以建议：

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
