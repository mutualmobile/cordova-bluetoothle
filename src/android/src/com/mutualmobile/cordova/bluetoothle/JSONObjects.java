package com.mutualmobile.cordova.bluetoothle;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.bluetooth.BluetoothProfile;
import android.os.ParcelUuid;
import android.util.Base64;
import android.util.Log;


public class JSONObjects {

  public static JSONObject asAdapter(BluetoothAdapter a) {
    JSONObject result = new JSONObject();
    try {
      result.put("address", a.getAddress());
      result.put("name", a.getName());
      result.put("enabled", a.isEnabled());
      result.put("discovering", a.isDiscovering());
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  // The following data type values are assigned by Bluetooth SIG.
  // For more details refer to Bluetooth 4.1 specification, Volume 3, Part C, Section 18.
  private static final int DATA_TYPE_FLAGS = 0x01;
  private static final int DATA_TYPE_SERVICE_UUIDS_16_BIT_PARTIAL = 0x02;
  private static final int DATA_TYPE_SERVICE_UUIDS_16_BIT_COMPLETE = 0x03;
  private static final int DATA_TYPE_SERVICE_UUIDS_32_BIT_PARTIAL = 0x04;
  private static final int DATA_TYPE_SERVICE_UUIDS_32_BIT_COMPLETE = 0x05;
  private static final int DATA_TYPE_SERVICE_UUIDS_128_BIT_PARTIAL = 0x06;
  private static final int DATA_TYPE_SERVICE_UUIDS_128_BIT_COMPLETE = 0x07;
  private static final int DATA_TYPE_LOCAL_NAME_SHORT = 0x08;
  private static final int DATA_TYPE_LOCAL_NAME_COMPLETE = 0x09;
  private static final int DATA_TYPE_TX_POWER_LEVEL = 0x0A;
  private static final int DATA_TYPE_SERVICE_DATA = 0x16;
  private static final int DATA_TYPE_MANUFACTURER_SPECIFIC_DATA = 0xFF;


  public static JSONObject asDevice(BluetoothDevice device, int rssi, byte[] ad) {
    JSONObject result = new JSONObject();
    try {
      result.put("address", device.getAddress());
      result.put("name", device.getName());
      result.put("rssi", rssi);

      int currentPos = 0;
      int advertiseFlag = -1;
      List<ParcelUuid> serviceUuids = new ArrayList<ParcelUuid>();
      String localName = null;
      int txPowerLevel = Integer.MIN_VALUE;

      Map<String, byte[]> manufacturerData = new HashMap<String, byte[]>();
      Map<ParcelUuid, byte[]> serviceData = new HashMap<ParcelUuid, byte[]>();

      while (currentPos < ad.length) {
        // length is unsigned int.
        int length = ad[currentPos++] & 0xFF;
        if (length == 0) {
          break;
        }
        // Note the length includes the length of the field type itself.
        int dataLength = length - 1;
        // fieldType is unsigned int.
        int fieldType = ad[currentPos++] & 0xFF;
        switch (fieldType) {
          case DATA_TYPE_FLAGS:
            advertiseFlag = ad[currentPos] & 0xFF;
            break;
          case DATA_TYPE_SERVICE_UUIDS_16_BIT_PARTIAL:
          case DATA_TYPE_SERVICE_UUIDS_16_BIT_COMPLETE:
            parseServiceUuid(ad, currentPos, dataLength, UUID_BYTES_16_BIT, serviceUuids);
            break;
          case DATA_TYPE_SERVICE_UUIDS_32_BIT_PARTIAL:
          case DATA_TYPE_SERVICE_UUIDS_32_BIT_COMPLETE:
            parseServiceUuid(ad, currentPos, dataLength, UUID_BYTES_32_BIT, serviceUuids);
            break;
          case DATA_TYPE_SERVICE_UUIDS_128_BIT_PARTIAL:
          case DATA_TYPE_SERVICE_UUIDS_128_BIT_COMPLETE:
            parseServiceUuid(ad, currentPos, dataLength, UUID_BYTES_128_BIT, serviceUuids);
            break;
          case DATA_TYPE_LOCAL_NAME_SHORT:
          case DATA_TYPE_LOCAL_NAME_COMPLETE:
            localName = new String(extractBytes(ad, currentPos, dataLength));
            break;
          case DATA_TYPE_TX_POWER_LEVEL:
            txPowerLevel = ad[currentPos];
            break;
          case DATA_TYPE_SERVICE_DATA:
            // The first two bytes of the service data are service data UUID in little
            // endian. The rest bytes are service data.
            int serviceUuidLength = UUID_BYTES_16_BIT;
            byte[] serviceDataUuidBytes = extractBytes(ad, currentPos, serviceUuidLength);
            ParcelUuid serviceDataUuid = parseUuidFrom(serviceDataUuidBytes);
            byte[] serviceDataArray = extractBytes(ad, currentPos + serviceUuidLength, dataLength - serviceUuidLength);
            serviceData.put(serviceDataUuid, serviceDataArray);
            break;
          case DATA_TYPE_MANUFACTURER_SPECIFIC_DATA:
            // The first two bytes of the manufacturer specific data are
            // manufacturer ids in little endian.
            int manufacturerId = ((ad[currentPos + 1] & 0xFF) << 8) + (ad[currentPos] & 0xFF);
            byte[] manufacturerDataBytes = extractBytes(ad, currentPos + 2, dataLength - 2);
            manufacturerData.put(Integer.toString(manufacturerId), manufacturerDataBytes);
            break;
          default:
            // Just ignore, we don't handle such data type.
            break;
        }
        currentPos += dataLength;
      }

      if (serviceUuids.isEmpty()) {
        serviceUuids = null;
      }

      JSONArray uuids = new JSONArray();
      for (ParcelUuid u : serviceUuids) {
        uuids.put(u);
      }
      result.put("uuids", uuids);

      JSONObject serviceDataJson = new JSONObject();
      for (Entry<ParcelUuid, byte[]> entry : serviceData.entrySet()) {
        serviceDataJson.put(entry.getKey().toString(), Base64.encodeToString(entry.getValue(), Base64.NO_WRAP));
      }
      result.put("serviceData", serviceDataJson);

      JSONObject manufacturerDataJson = new JSONObject();
      for (Entry<String, byte[]> entry : manufacturerData.entrySet()) {
        manufacturerDataJson.put(entry.getKey(), Base64.encodeToString(entry.getValue(), Base64.NO_WRAP));
      }
      result.put("manufacturerData", manufacturerDataJson);
      result.put("txPowerLevel", txPowerLevel);
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }

  public static JSONObject asDevice(BluetoothGatt gatt, BluetoothManager manager, int rssi) {
    JSONObject result = asDevice(gatt, manager);
    try {
      result.put("rssi", rssi);
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asDevice(BluetoothGatt gatt, BluetoothManager manager) {
    JSONObject result = new JSONObject();
    try {
      result.put("address", gatt.getDevice().getAddress());
      result.put("name", gatt.getDevice().getName());

      JSONArray uuids = new JSONArray();
      for (BluetoothGattService service : gatt.getServices()) {
        uuids.put(service.getUuid());
      }
      result.put("uuids", uuids);

      result.put("connected", manager.getConnectionState(gatt.getDevice(), BluetoothProfile.GATT_SERVER) == BluetoothProfile.STATE_CONNECTED);
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asService(BluetoothGattService s, BluetoothDevice d) {
    JSONObject result = new JSONObject();
    try {
      result.put("uuid", s.getUuid().toString());
      result.put("isPrimary", s.getType() == BluetoothGattService.SERVICE_TYPE_PRIMARY);
      result.put("instanceId", String.valueOf(s.getInstanceId()));
      result.put("deviceAddress", d.getAddress());
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asCharacteristic(BluetoothGattCharacteristic c) {
    JSONObject result = new JSONObject();
    try {
      result.put("uuid", c.getUuid().toString());
      result.put("service", c.getService().getUuid().toString());

      JSONArray propArray = new JSONArray();
      int properties = c.getProperties();
      if ((properties & BluetoothGattCharacteristic.PROPERTY_BROADCAST) != 0) {
        propArray.put("broadcast");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_EXTENDED_PROPS) != 0) {
        propArray.put("extendedProperties");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_INDICATE) != 0) {
        propArray.put("indicate");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_NOTIFY) != 0) {
        propArray.put("notify");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_READ) != 0) {
        propArray.put("read");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_SIGNED_WRITE) != 0) {
        propArray.put("authenticatedSignedWrites");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_WRITE) != 0) {
        propArray.put("write");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_WRITE_NO_RESPONSE) != 0) {
        propArray.put("writeWithoutResponse");
      }
      result.put("properties", propArray);

      result.put("instanceId", c.getInstanceId());
      byte[] value = c.getValue();
      if (value == null) {
        result.put("value", null);
      }
      else {
        result.put("value", Base64.encodeToString(c.getValue(), Base64.NO_WRAP));
      }
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asDescriptor(BluetoothGattDescriptor d) {
    JSONObject result = new JSONObject();
    try {
      result.put("uuid", d.getUuid().toString());
      result.put("characteristic", d.getCharacteristic().getUuid().toString());
      result.put("value", Base64.encodeToString(d.getValue(), Base64.NO_WRAP));
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asError(Exception e) {
    JSONObject result = new JSONObject();
    try {
      result.put("message", e.getMessage());

      StringWriter sw = new StringWriter();
      e.printStackTrace(new PrintWriter(sw));
      result.put("stack", sw.toString());
    }
    catch (JSONException other) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", other);
    }
    return result;
  }


  private static int parseServiceUuid(byte[] scanRecord, int currentPos, int dataLength, int uuidLength, List<ParcelUuid> serviceUuids) {
    while (dataLength > 0) {
      byte[] uuidBytes = extractBytes(scanRecord, currentPos,
          uuidLength);
      serviceUuids.add(parseUuidFrom(uuidBytes));
      dataLength -= uuidLength;
      currentPos += uuidLength;
    }
    return currentPos;
  }


  private static byte[] extractBytes(byte[] scanRecord, int start, int length) {
    byte[] bytes = new byte[length];
    System.arraycopy(scanRecord, start, bytes, 0, length);
    return bytes;
  }


  /** Length of bytes for 16 bit UUID */
  public static final int UUID_BYTES_16_BIT = 2;
  /** Length of bytes for 32 bit UUID */
  public static final int UUID_BYTES_32_BIT = 4;
  /** Length of bytes for 128 bit UUID */
  public static final int UUID_BYTES_128_BIT = 16;
  public static final ParcelUuid BASE_UUID = ParcelUuid.fromString("00000000-0000-1000-8000-00805F9B34FB");


  public static ParcelUuid parseUuidFrom(byte[] uuidBytes) {
    if (uuidBytes == null) {
      throw new IllegalArgumentException("uuidBytes cannot be null");
    }
    int length = uuidBytes.length;
    if (length != UUID_BYTES_16_BIT && length != UUID_BYTES_32_BIT &&
        length != UUID_BYTES_128_BIT) {
      throw new IllegalArgumentException("uuidBytes length invalid - " + length);
        }
    // Construct a 128 bit UUID.
    if (length == UUID_BYTES_128_BIT) {
      ByteBuffer buf = ByteBuffer.wrap(uuidBytes).order(ByteOrder.LITTLE_ENDIAN);
      long msb = buf.getLong(8);
      long lsb = buf.getLong(0);
      return new ParcelUuid(new UUID(msb, lsb));
    }
    // For 16 bit and 32 bit UUID we need to convert them to 128 bit value.
    // 128_bit_value = uuid * 2^96 + BASE_UUID
    long shortUuid;
    if (length == UUID_BYTES_16_BIT) {
      shortUuid = uuidBytes[0] & 0xFF;
      shortUuid += (uuidBytes[1] & 0xFF) << 8;
    } else {
      shortUuid = uuidBytes[0] & 0xFF;
      shortUuid += (uuidBytes[1] & 0xFF) << 8;
      shortUuid += (uuidBytes[2] & 0xFF) << 16;
      shortUuid += (uuidBytes[3] & 0xFF) << 24;
    }
    long msb = BASE_UUID.getUuid().getMostSignificantBits() + (shortUuid << 32);
    long lsb = BASE_UUID.getUuid().getLeastSignificantBits();
    return new ParcelUuid(new UUID(msb, lsb));
  }


}
