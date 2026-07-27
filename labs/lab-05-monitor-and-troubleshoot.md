<div align="center">

# 🧪 Lab 05 — Monitor & Troubleshoot an Update

[![Lab](https://img.shields.io/badge/Lab-05-orange)](../README.md) [![Focus](https://img.shields.io/badge/Focus-Troubleshooting-5391FE)](../docs/08-troubleshooting.md)

[⬅️ Lab 04](./lab-04-driver-update-policy.md) • [🏠 Home](../README.md) • [📘 Troubleshooting Guide](../docs/08-troubleshooting.md)

</div>

---

## 🎯 Objective

Use Intune reports and local Windows diagnostics to investigate a device that is pending, failed or not reporting the expected update state.

## 🛠️ Tasks

1. Select a lab device with a known update state.
2. Record its Intune check-in time, Windows build, policy assignment and report state.
3. Run the repository diagnostic scripts as administrator.
4. Review these event logs:

```text
Microsoft-Windows-WindowsUpdateClient/Operational
Microsoft-Windows-UpdateOrchestrator/Operational
Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin
```

5. Generate `Get-WindowsUpdateLog` output.
6. Identify whether the issue is policy, applicability, scan, download, installation, restart or reporting.
7. Apply the least disruptive remediation.
8. Re-sync and confirm the final state.

## 🧾 Troubleshooting Worksheet

| Field | Evidence |
|---|---|
| Device name/model | |
| Windows release/build | |
| Intune last check-in | |
| Assigned policy | |
| Intended update | |
| Current phase | |
| Error code | |
| Relevant event | |
| Root cause | |
| Remediation | |
| Final result | |

## ✅ Success Criteria

- [ ] Root cause is based on evidence, not assumption.
- [ ] Diagnostic files are collected before destructive remediation.
- [ ] Device reaches the expected state or a complete escalation package is prepared.
- [ ] Lessons learned are added to the support knowledge base.

---

<div align="center">

[⬅️ Lab 04](./lab-04-driver-update-policy.md) • [⬆ Back to Top](#-lab-05--monitor--troubleshoot-an-update) • [🏠 Repository Home](../README.md)

**Lab maintained by [Xuan Toan Nguyen](https://github.com/toannguyenitoz) • #ToanNguyenITOz**

</div>
