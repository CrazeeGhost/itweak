#import <arpa/inet.h>
#import <net/if.h>
#import <ifaddrs.h>
#import <net/if_dl.h>

static NSString *const DataCounterKeyWWANSent = @"WWANSent";
static NSString *const DataCounterKeyWWANReceived = @"WWANReceived";

NSDecimalNumber *DataUsage()
{

    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;

    u_int32_t WWANSent = 0;
    u_int32_t WWANReceived = 0;

    if (getifaddrs(&addrs) == 0)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
#ifdef DEBUG
                const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
                if(ifa_data != NULL)
                {
                    NSLog(@"Interface name %s: sent %tu received %tu",cursor->ifa_name,ifa_data->ifi_obytes,ifa_data->ifi_ibytes);
                }
#endif

                // name of interfaces:
                // en0 is WiFi
                // pdp_ip0 is WWAN

                NSString *name = [NSString stringWithFormat:@"%s",cursor->ifa_name];
                if ([name hasPrefix:@"pdp_ip"])
                {
                    const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
                    if(ifa_data != NULL)
                    {
                        WWANSent += ifa_data->ifi_obytes;
                        WWANReceived += ifa_data->ifi_ibytes;
                    }
                }
            }

            cursor = cursor->ifa_next;
        }

        freeifaddrs(addrs);
    }
	float totalMB = ((WWANSent + WWANReceived) / 1024) / 1024;
	return [[NSDecimalNumber alloc] initWithFloat:totalMB];
}

