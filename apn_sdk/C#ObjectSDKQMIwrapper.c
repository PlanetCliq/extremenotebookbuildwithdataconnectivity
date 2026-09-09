#include "C#ObjectSDKQMIwrapper.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int QmiCoreInitialize(const char* device_node);
extern int QmiCoreShutdown(void);
extern int QmiCoreSendWdsDefinePdp(uint32_t id, const char* apn, int ip_type);
extern int QmiCoreSendWdsActivatePdp(uint32_t id);
extern int QmiCoreSendWdsDeactivatePdp(uint32_t id);
extern int QmiCoreSendQosConfigure(uint32_t id, int priority, uint32_t ul, uint32_t dl, uint32_t latency);
extern int QmiCoreSendDmsEsimActivate(const char* eid);
extern int QmiCoreHardwareKillSwitchTrigger(bool isolated);

int QmiSdkInitialize(const char* device_node) {
    if (!device_node) {
        fprintf(stderr, "[-] [C#-WRAPPER] Device node parameter is NULL.\n");
        return -1;
    }
    printf("[+] [C#-WRAPPER] Initializing Qualcomm Snapdragon Baseband interface: %s\n", device_node);
    return QmiCoreInitialize(device_node);
}

int QmiSdkShutdown(void) {
    printf("[+] [C#-WRAPPER] Releasing Qualcomm Baseband client handles.\n");
    return QmiCoreShutdown();
}

int QmiSdkDefinePdpContext(const QmiCarrierProfile* profile) {
    if (!profile) {
        fprintf(stderr, "[-] [C#-WRAPPER] Profile parameter is NULL.\n");
        return -1;
    }
    printf("[+] [C#-WRAPPER] Marshalling PDP Profile %u: Carrier='%s', APN='%s', MCC/MNC=%s/%s\n",
           profile->profile_id, profile->carrier_name, profile->apn, profile->mcc, profile->mnc);
    return QmiCoreSendWdsDefinePdp(profile->profile_id, profile->apn, (int)profile->ip_type);
}

int QmiSdkActivatePdpContext(uint32_t profile_id) {
    printf("[+] [C#-WRAPPER] Forwarding PDP Context Activation request for ID: %u\n", profile_id);
    return QmiCoreSendWdsActivatePdp(profile_id);
}

int QmiSdkDeactivatePdpContext(uint32_t profile_id) {
    printf("[+] [C#-WRAPPER] Forwarding PDP Context Deactivation request for ID: %u\n", profile_id);
    return QmiCoreSendWdsDeactivatePdp(profile_id);
}

int QmiSdkConfigureQoS(uint32_t profile_id, QmiQoSPriority priority, uint32_t ul_mbps, uint32_t dl_mbps, uint32_t latency_ms) {
    printf("[+] [C#-WRAPPER] Applying QoS: Profile=%u, Priority=%d, UL=%u Mbps, DL=%u Mbps, Latency=%u ms\n",
           profile_id, (int)priority, ul_mbps, dl_mbps, latency_ms);
    return QmiCoreSendQosConfigure(profile_id, (int)priority, ul_mbps, dl_mbps, latency_ms);
}

int QmiSdkActivateEsimProfile(const char* eid) {
    if (!eid) return -1;
    printf("[+] [C#-WRAPPER] GSMA-SGP.32 eUICC Mutual LPA Handshake on Target EID: %s\n", eid);
    return QmiCoreSendDmsEsimActivate(eid);
}

int QmiSdkSetHardwareKillSwitch(bool isolated) {
    printf("[+] [C#-WRAPPER] Hardware Discrete RF Kill-Switch Triggered: %s\n", isolated ? "ISOLATED" : "ACTIVE");
    return QmiCoreHardwareKillSwitchTrigger(isolated);
}

int QmiSdkGetCarrierRegistration(char* out_carrier_name, uint32_t max_len) {
    if (!out_carrier_name || max_len == 0) return -1;
    strncpy(out_carrier_name, "Qualcomm SDX90 Connected - Multi-eSIM GSMA Active", max_len - 1);
    out_carrier_name[max_len - 1] = '\0';
    return 0;
}
