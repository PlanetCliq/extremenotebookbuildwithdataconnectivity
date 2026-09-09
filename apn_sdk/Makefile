CC ?= gcc
CFLAGS ?= -Wall -Wextra -O2 -fPIC
LDFLAGS ?= -shared

TARGET_LIB = libqmi_carrier_sdk.so
TARGET_BIN = test_apn

SRCS = C\#ObjectSDKQMIwrapper.c qmi_core.c apn_parser.c policy_engine.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET_LIB) $(TARGET_BIN)

$(TARGET_LIB): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

$(TARGET_BIN): test_apn.o $(TARGET_LIB)
	$(CC) -o $@ test_apn.o -L. -lqmi_carrier_sdk -Wl,-rpath,.

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) test_apn.o $(TARGET_LIB) $(TARGET_BIN)

.PHONY: all clean
