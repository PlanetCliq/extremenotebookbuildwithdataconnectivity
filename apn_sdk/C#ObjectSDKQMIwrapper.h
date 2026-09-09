#ifndef CS_OBJECT_SDK_QMI_WRAPPER_H
#define CS_OBJECT_SDK_QMI_WRAPPER_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    QMI_IP_TYPE_V4 = 4,
    QMI_IP_TYPE_V6 = 6,
    QMI_IP_TYPE_V4V6 = 10
} QmiIpType;

typedef enum {
    QMI_QOS_PRIORITY_LOW = 1,
    QMI_QOS_PRIORITY_NORMAL = 2,
    QMI_QOS_PRIORITY_HIGH = 3,
    QMI_QOS_PRIORITY_CRITICAL = 4,
    QMI_QOS_PRIORITY_MAXIMUM = 5
} QmiQoSPriority;

typedef struct {
    uint32_t profile_id;
    char carrier_id[32];
    char carrier_name[64];
    char apn[64];
    char mcc[8];
    char mnc[8];
    QmiIpType ip_type;
    bool is_roaming_allowed;
    QmiQoSPriority qos_priority;
    uint32_t throughput_ul_mbps;
    uint32_t throughput_dl_mbps;
    uint32_t latency_budget_ms;
} QmiCarrierProfile;

// C# P/Invoke Compatible C ABI Export Signatures
int QmiSdkInitialize(const char* device_node);
int QmiSdkShutdown(void);
int QmiSdkDefinePdpContext(const QmiCarrierProfile* profile);
int QmiSdkActivatePdpContext(uint32_t profile_id);
int QmiSdkDeactivatePdpContext(uint32_t profile_id);
int QmiSdkConfigureQoS(uint32_t profile_id, QmiQoSPriority priority, uint32_t ul_mbps, uint32_t dl_mbps, uint32_t latency_ms);
int QmiSdkActivateEsimProfile(const char* eid);
int QmiSdkSetHardwareKillSwitch(bool isolated);
int QmiSdkGetCarrierRegistration(char* out_carrier_name, uint32_t max_len);

#ifdef __cplusplus
}
#endif

#endif // CS_OBJECT_SDK_QMI_WRAPPER_H
