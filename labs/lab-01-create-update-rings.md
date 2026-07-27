<div align="center">

# 🧪 Lab 01 — Create Pilot & Production Update Rings

[![Lab](https://img.shields.io/badge/Lab-01-orange)](../README.md) [![Level](https://img.shields.io/badge/Level-Intermediate-yellow)](../docs/02-update-rings.md)

[🏠 Home](../README.md) • [📘 Theory](../docs/02-update-rings.md) • [➡️ Next Lab](./lab-02-feature-update-deployment.md)

</div>

---

## 🎯 Objective

Create staged Windows update rings for an IT pilot and broad production group, then validate policy assignment and restart behaviour.

## 📋 Prerequisites

- Intune tenant and suitable administrative permission
- Two Microsoft Entra device security groups
- At least one enrolled Windows test device in each group
- A documented change and rollback plan

## 🏷️ Suggested Groups

```text
GRP-Intune-WUfB-IT-Pilot
GRP-Intune-WUfB-Production
```

## 🛠️ Tasks

### Task 1 — Create the IT pilot ring

1. Go to **Devices → Windows updates → Update rings**.
2. Select **Create profile**.
3. Name it `WUfB-Ring-01-ITPilot-Prod`.
4. Configure quality update timing, automatic update behaviour, deadline, grace period, active hours and notifications according to your lab design.
5. Assign the IT pilot group.
6. Review and create.

### Task 2 — Create the production ring

1. Create `WUfB-Ring-03-Broad-Prod`.
2. Use a later rollout position than the IT pilot.
3. Assign the production group.
4. Exclude pilot groups where group design requires it.

### Task 3 — Sync and validate

On the test device:

```text
Settings → Accounts → Access work or school → Connected account → Info → Sync
```

Record:

- Last sync time
- Assigned ring
- Windows edition, version and build
- Restart notification behaviour
- Intune deployment state

## ✅ Success Criteria

- [ ] Each test device receives only the intended ring.
- [ ] Policy status is successful or pending for an understood reason.
- [ ] Deadlines and notifications match the design.
- [ ] Pilot and production assignments do not conflict.
- [ ] Evidence screenshots and notes are saved.

## 🧹 Cleanup

Remove lab assignments or delete the profiles when the exercise is complete. Do not leave experimental settings targeted to production devices.

---

<div align="center">

[⬆ Back to Top](#-lab-01--create-pilot--production-update-rings) • [🏠 Repository Home](../README.md) • [➡️ Lab 02](./lab-02-feature-update-deployment.md)

**Lab maintained by [Xuan Toan Nguyen](https://github.com/toannguyenitoz) • #ToanNguyenITOz**

</div>
