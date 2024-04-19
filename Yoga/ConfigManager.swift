//
//  Config.swift
//  Yoga
//
//  Created by Paul Wilkinson on 2024-04-18.
//  Copyright © 2024 Paul Wilkinson. All rights reserved.
//

import Foundation
import Thrift

extension FileManager {
    public func secureCopyItem(at srcURL: URL, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
            print("dunn")
        } catch (let error) {
            print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
            return false
        }
        return true
    }
    
    public func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

class ConfigManager {
    static let instance = ConfigManager()
    
//    static func initialize() {
//        ConfigManager.instance = ConfigManager()
////        ConfigManager.instance.init()
//    }
//    
//    static func shutdown() {
//        ConfigManager.instance = nil
//    }
    
    static func getInstance() -> ConfigManager {
        return ConfigManager.instance
    }
    
    public var data: ConfigData
    public var ready: Bool
    
    private init() {
        ready = false
//        FILE* fp = fopen(filePath, "rt ");
//        assert(fp != nullptr);
//        fseek(fp, 0, SEEK_END);
//        size_t filesize = ftell(fp);
//        fseek(fp, 0, SEEK_SET);
//        void* buf = malloc(filesize+1);
//        printf("file is %d bytes", (int)filesize);
//        TMemoryBuffer* memoryBuffer = new TMemoryBuffer();
//        std::shared_ptr<apache::thrift::transport::TTransport> transport(memoryBuffer);
//        memoryBuffer->resetBuffer((uint8_t*)buf, (uint32_t)filesize);
//        filesize = fread(buf, 1, filesize+1, fp);
//        TProtocol* protocol = new TJSONProtocol(transport);
    
//        mData = new Yoga::Config::Data;
//        assert(mData != nullptr);
//        mData->read(proto);
        do {
            // Fake config download
            let sourcePath = Bundle.main.url(forResource:"config", withExtension: "bin")!
            let url = FileManager.default.getDocumentsDirectory().appendingPathComponent("config.bin")
            FileManager.default.secureCopyItem(at:sourcePath, to:url)
            let path = url.path
            let transport = try TFileTransport(filename: path)
            let proto = TJSONProtocol(on: transport)
            try self.data = ConfigData.read(from: proto)
            ready = true
        }  catch {
            self.data = ConfigData(schemaVersionId: 0)
            print(error)
        }
//        fclose(fp);
//        fp = nullptr;
//        free(buf);
//        buf = nullptr;
//    
//        delete protocol;
    //    protocol = nullptr;
    }
}
