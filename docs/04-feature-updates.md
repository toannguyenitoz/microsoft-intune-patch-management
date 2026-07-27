<div align="center">

# 🚀 Windows Feature Updates

[![Module](https://img.shields.io/badge/Module-04-blue)](../README.md) [![Windows 11](https://img.shields.io/badge/Windows-11-0078D4?logo=windows11&logoColor=white)](https://learn.microsoft.com/intune/device-updates/windows/feature-updates)

**Version targeting • Compatibility • Safeguard holds • Gradual rollout**

[⬅️ Quality Updates](./03-quality-updates.md) • [🏠 Home](../README.md) • [➡️ Driver Updates](./05-driver-updates.md)

</div>

---

## 📌 Purpose

Feature update policies control which Windows release targeted devices are eligible to install. They can keep devices on an approved version or move them to a newer supported release while preventing unintended upgrades beyond the target.

> [!NOTE]
> A feature update policy does not downgrade a device that already runs a newer Windows version.

---

## 🧭 Deployment Options

Intune feature update rollout options can make an update available:

- As soon as possible
- On a specified date
- Gradually across the targeted population

Availability does not guarantee immediate installation. Device scan timing, readiness, active use, deadlines and restart behaviour still influence completion.

---

## 🏗️ Recommended Lifecycle

```mermaid
flowchart LR
    A[Inventory and readiness] --> B[Application validation]
    B --> C[Technical pilot]
    C --> D[Business pilot]
    D --> E[Gradual production rollout]
    E --> F[Compliance follow-up]
    F --> G[Retire old release]
```

### Phase 1 – Discover

- Inventory Windows editions, versions, builds and hardware models.
- Identify applications, security agents, VPN clients, drivers and add-ins.
- Find unsupported hardware and devices approaching end of service.

### Phase 2 – Validate

- Test installation, rollback and recovery.
- Validate business-critical workflows.
- Confirm disk space, firmware and driver readiness.

### Phase 3 – Pilot

- Start with representative IT devices.
- Expand to business champions across departments and hardware models.
- Review failures and safeguard holds before production.

### Phase 4 – Deploy

- Use staged or gradual availability.
- Communicate restart expectations.
- Track version adoption and installation failures.

### Phase 5 – Close

- Remediate remaining exceptions.
- Remove or replace unsupported devices.
- Document lessons learned and update the next deployment plan.

---

## 🛑 Safeguard Holds

Microsoft can apply safeguard holds when a known compatibility issue might affect a device. A held device is temporarily prevented from receiving the feature update.

Recommended response:

1. Confirm the device is otherwise correctly targeted.
2. Review the compatibility or safeguard reporting.
3. Identify the affected application, driver or hardware condition.
4. Wait for remediation or deploy the vendor fix.
5. Reassess before considering any override.

> [!CAUTION]
> Bypassing safeguards increases risk. Use only after testing, documented risk acceptance and a validated recovery plan.

---

## ⚙️ Configuration Workflow

1. Open **Devices → Windows updates → Feature updates**.
2. Create a profile.
3. Select the target Windows release.
4. Choose rollout timing.
5. Assign the pilot device group.
6. Monitor the organisational feature update report.
7. Confirm devices reach an offer-ready or later state.
8. Expand the assignment according to change approval.

### Policy naming example

```text
WUfB-FU-Windows11-ApprovedRelease-Pilot
WUfB-FU-Windows11-ApprovedRelease-Production
```

---

## ⚠️ Deferral Conflict Avoidance

When a feature update policy is the authoritative version-control mechanism:

- Prefer setting feature update deferral in applicable update rings to `0` after the feature policy is confirmed processed.
- Keep update rings for user experience, deadlines, restart and notification settings.
- Avoid multiple feature update policies targeting the same device.
- Validate co-management workload ownership.

---

## ✅ Readiness Checklist

- [ ] Target release remains supported for the planned lifecycle.
- [ ] Hardware meets Windows requirements.
- [ ] Critical apps and security agents are validated.
- [ ] BIOS, firmware and critical drivers are current.
- [ ] Free disk space is sufficient.
- [ ] BitLocker recovery keys are escrowed and accessible.
- [ ] Service desk has support guidance.
- [ ] Rollback and recovery procedures were tested.
- [ ] Feature update reporting is available.
- [ ] Safeguard holds are reviewed rather than ignored.

---

## 📊 Useful Deployment Metrics

- Percentage on target feature version
- Devices in progress, paused, failed or rollback state
- Safeguard hold count
- Failure rate by hardware model
- Application incidents attributed to the upgrade
- Average days from offer to completed installation
- Devices remaining on out-of-service releases

---

## 🔗 Official References

- [Manage Windows feature updates](https://learn.microsoft.com/intune/device-updates/windows/feature-updates)
- [Configure feature update policies](https://learn.microsoft.com/intune/device-updates/windows/configure-feature-update-policy)
- [Configure rollout options](https://learn.microsoft.com/intune/device-updates/windows/configure-rollout-options)

---

<div align="center">

[⬅️ Quality Updates](./03-quality-updates.md) • [⬆ Back to Top](#-windows-feature-updates) • [➡️ Driver Updates](./05-driver-updates.md)

**Maintained by [Xuan Toan Nguyen](https://github.com/toannguyenitoz) • #ToanNguyenITOz**

</div>
