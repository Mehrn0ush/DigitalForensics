import os
import struct

def parse_srum_database(file_path):
    with open(file_path, "rb") as f:
        # Read the header information
        header = f.read(40)
        header_data = struct.unpack("<LHHLL", header)
        record_count = header_data[0]
        record_size = header_data[1]
        print("Record count:", record_count)
        print("Record size:", record_size)
        
        # Read the records
        for i in range(record_count):
            record = f.read(record_size)
            record_data = struct.unpack("<QQQQQQQQQQ", record)
            print("Record", i, ":", record_data)

file_path = os.path.join(os.environ["SystemRoot"], "System32", "sru", "srumdb.dat")
parse_srum_database(file_path)
