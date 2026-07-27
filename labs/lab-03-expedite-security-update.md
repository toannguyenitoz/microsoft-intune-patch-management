<div align="center">

# 🧪 Lab 03 — Expedite a Security Update

[![Lab](https://img.shields.io/badge/Lab-03-orange)](../README.md) [![Priority](https://img.shields.io/badge/Priority-Emergency-critical)](../docs/03-quality-updates.md)

[⬅️ Lab 02](./lab-02-feature-update-deployment.md) • [🏠 Home](../README.md) • [➡️ Lab 04](./lab-04-driver-update-policy.md)

</div>

---

## 🎯 Objective

Simulate an emergency response by creating an expedite policy for an eligible Windows security update and monitoring a small validation group.

## ⚠️ Safety Rule

Use lab devices only. An expedite policy can override normal deferral timing and accelerate restart enforcement.

## 🛠️ Tasks

1. Confirm the test device is supported, active and assigned to an update ring.
2. Go to **Devices → Windows updates → Quality updates** and create an expedited update policy.
3. Select an eligible security update available in the tenant.
4. Configure the restart deadline according to the lab scenario.
5. Assign only `GRP-Intune-WUfB-Emergency-Test`.
6. Sync the test device.
7. Monitor the expedited update report and local Windows Update events.
8. Record offer, download, installation, restart and final build timestamps.

## 🧾 Incident Evidence

```text
Risk or vulnerability:
Affected devices:
Selected update:
Policy name:
Assignment group:
Deployment start:
Deadline:
Success percentage:
Failures and actions:
Closure time:
```

## ✅ Success Criteria

- [ ] Policy targets only the emergency test group.
- [ ] Eligible update is offered despite normal deferral timing.
- [ ] Restart behaviour matches the policy.
- [ ] Final build is verified.
- [ ] Failure and closure evidence is documented.

---

<div align="center">

[⬅️ Lab 02](./lab-02-feature-update-deployment.md) • [⬆ Back to Top](#-lab-03--expedite-a-security-update) • [➡️ Lab 04](./lab-04-driver-update-policy.md)

**Lab maintained by [Xuan Toan Nguyen](https://github.com/toannguyenitoz) • #ToanNguyenITOz**

</div>
