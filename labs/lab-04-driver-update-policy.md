<div align="center">

# 🧪 Lab 04 — Create a Driver Update Policy

[![Lab](https://img.shields.io/badge/Lab-04-orange)](../README.md) [![Focus](https://img.shields.io/badge/Focus-Drivers-0078D4)](../docs/05-driver-updates.md)

[⬅️ Lab 03](./lab-03-expedite-security-update.md) • [🏠 Home](../README.md) • [➡️ Lab 05](./lab-05-monitor-and-troubleshoot.md)

</div>

---

## 🎯 Objective

Create a manual-approval driver policy, review applicable drivers and approve one update for a representative pilot device.

## 🛠️ Tasks

1. Create a device group containing one non-critical Windows test device.
2. Go to **Devices → Windows updates → Driver updates**.
3. Create `WUfB-Driver-LaptopFleet-Pilot`.
4. Select the manual approval model.
5. Assign the pilot group.
6. Wait for applicable drivers to populate.
7. Review driver class, vendor, version, affected device and operational risk.
8. Approve a suitable low-risk driver for the pilot.
9. Monitor policy and device status.
10. Validate the affected component after installation.

## 🔎 Validation Matrix

| Item | Result |
|---|---|
| Driver name and class | |
| Current version | |
| Approved version | |
| Restart required | |
| Device installation status | |
| Hardware function after update | |
| Rollback method confirmed | |

## ✅ Success Criteria

- [ ] Only the test group is assigned.
- [ ] Driver was reviewed before approval.
- [ ] Installation status is recorded.
- [ ] Hardware remains functional.
- [ ] Rollback steps are documented.

---

<div align="center">

[⬅️ Lab 03](./lab-03-expedite-security-update.md) • [⬆ Back to Top](#-lab-04--create-a-driver-update-policy) • [➡️ Lab 05](./lab-05-monitor-and-troubleshoot.md)

**Lab maintained by [Xuan Toan Nguyen](https://github.com/toannguyenitoz) • #ToanNguyenITOz**

</div>
