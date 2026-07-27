<div align="center">

# 🧪 Lab 02 — Deploy a Windows Feature Update

[![Lab](https://img.shields.io/badge/Lab-02-orange)](../README.md) [![Focus](https://img.shields.io/badge/Focus-Feature%20Update-0078D4)](../docs/04-feature-updates.md)

[⬅️ Lab 01](./lab-01-create-update-rings.md) • [🏠 Home](../README.md) • [➡️ Lab 03](./lab-03-expedite-security-update.md)

</div>

---

## 🎯 Objective

Create a feature update policy that targets an approved Windows release, deploy it to a pilot group and monitor readiness and installation state.

## 📋 Prerequisites

- Enrolled supported Windows test devices
- Feature update pilot group
- Existing update ring for restart behaviour
- Confirmed application, disk-space and recovery readiness

## 🛠️ Tasks

1. Go to **Devices → Windows updates → Feature updates**.
2. Create a profile named `WUfB-FU-Windows11-TargetRelease-Pilot`.
3. Select the Windows release approved for your lab tenant.
4. Choose an availability option: immediate, scheduled date or gradual rollout.
5. Assign only the feature-update pilot group.
6. Confirm that no conflicting feature update profile targets the same device.
7. Review feature-update deferral in the applicable update ring.
8. Sync the pilot device and generate the feature update report.

## 🔎 Validation Record

| Check | Result |
|---|---|
| Device is correctly targeted | |
| Policy processed by cloud service | |
| Device status is offer-ready or later | |
| No unexpected safeguard hold | |
| Download and installation progress | |
| Final Windows version and build | |
| Application validation completed | |

## ✅ Success Criteria

- [ ] Pilot device is protected from unintended newer releases.
- [ ] Intended feature release is offered.
- [ ] Restart experience follows the update ring.
- [ ] Critical apps work after upgrade.
- [ ] Recovery and rollback evidence is documented.

## 🧹 Cleanup

Remove the assignment or retain the profile only if it forms part of the approved lab design. Never target an unvalidated release to production devices.

---

<div align="center">

[⬅️ Lab 01](./lab-01-create-update-rings.md) • [⬆ Back to Top](#-lab-02--deploy-a-windows-feature-update) • [➡️ Lab 03](./lab-03-expedite-security-update.md)

**Lab maintained by [Xuan Toan Nguyen](https://github.com/toannguyenitoz) • #ToanNguyenITOz**

</div>
