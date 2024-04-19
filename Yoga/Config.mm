////
////  Config.mm
////  Yoga
////
////  Created by Paul Wilkinson on 1/17/19.
////  Copyright © 2019 Paul Wilkinson. All rights reserved.
////
//
//#include "Config.h"
//#include "../Config/Thrift/gen-cpp/Config_types.h"
////#include "../Config/Thrift/gen-cpp/Config_constants.h"
//
//#include <thrift/server/TSimpleServer.h>
//#include <thrift/server/TThreadedServer.h>
////#include <thrift/server/TNonblockingServer.h>
//#include <thrift/transport/TServerSocket.h>
//#include <thrift/concurrency/ThreadManager.h>
//#include <thrift/transport/TSocket.h>
//#include <thrift/transport/TTransport.h>
//#include <thrift/transport/TBufferTransports.h>
//#include <thrift/protocol/TBinaryProtocol.h>
//#include <thrift/protocol/TJSONProtocol.h>
//#include <boost/shared_ptr.hpp>
//
//#include "Utilities.h"
//#include <map>
//
//using namespace Yoga::Config;
//using namespace apache::thrift::transport;
//
//Config* Config::mInstance = nullptr;
//
//void ConfigInit()
//{
//	Config::Init();
//}
//
//void ConfigShutdown()
//{
//	Config::Shutdown();
//}
//
//void Config::Init()
//{
//	// Until we find a place to initialize the config early enough, we are stuck with this
//	if (mInstance == nullptr)
//	{
//		mInstance = new Config();
//	}
//}
//
//void Config::Shutdown()
//{
//	assert(mInstance != nullptr);
//	delete mInstance;
//	mInstance = nullptr;
//}
//
//int GetNumSessions()
//{
//	return Config::GetInstance()->GetNumSessions();
//}
//
//const char* GetSessionId(int n)
//{
//	return Config::GetInstance()->GetSessionId(n);
//}
//
//const char* GetSessionLocalizedName(int n)
//{
//	return Config::GetInstance()->GetSessionLocalizedName(n);
//}
//
//int GetSessionNumPoses(int n)
//{
//	return Config::GetInstance()->GetSessionNumPoses(n);
//}
//
//const char* GetSessionCardImage(int n)
//{
//	return Config::GetInstance()->GetSessionCardImage(n);
//}
//
//const char* GetSessionBackgroundImage(int n)
//{
//	return Config::GetInstance()->GetSessionBackgroundImage(n);
//}
//
//int GetSessionEnergyRating(int n)
//{
//	return Config::GetInstance()->GetSessionEnergyRating(n);
//}
//
//bool GetSessionComingSoon(int n)
//{
//	return Config::GetInstance()->GetSessionComingSoon(n);
//}
//
//const char* GetSessionPoseEnglishName(int sessionNum, int poseNum)
//{
//	return Config::GetInstance()->GetSessionPoseEnglishName(sessionNum, poseNum);
//}
//const char* GetSessionSubtitle(int sessionNum)
//{
//	return Config::GetInstance()->GetSessionSubtitle(sessionNum);
//}
//const char* GetSessionPoseSanskritName(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPoseSanskritName(sessionNum, poseNum);
//}
//int GetSessionPoseSeconds(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPoseSeconds(sessionNum, poseNum);
//}
//const char* GetSessionPosePoseFilename(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPosePoseFilename(sessionNum, poseNum);
//}
//const char* GetSessionPoseBackgroundFilename(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPoseBackgroundFilename(sessionNum, poseNum);
//}
//const char* GetSessionPoseMatFilename(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPoseMatFilename(sessionNum, poseNum);
//}
//const char* GetSessionPoseSwooshFilename(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPoseSwooshFilename(sessionNum, poseNum);
//}
//const char* GetSessionPoseShadowFilename(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPoseShadowFilename(sessionNum, poseNum);
//}
//const char* GetSessionPoseShortAudioFilename(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPoseShortAudioFilename(sessionNum, poseNum);
//}
//const char* GetSessionPoseDetailAudioFilename(int sessionNum, int poseNum){
//	return Config::GetInstance()->GetSessionPoseDetailAudioFilename(sessionNum, poseNum);
//}
//bool GetSessionPoseFlipped(int sessionNum, int poseNum) {
//	return Config::GetInstance()->GetSessionPoseFlipped(sessionNum, poseNum);
//}
//
//
//Config::Config()
//: mData(nullptr)
//{
//	using namespace ::apache::thrift;
//	using namespace ::apache::thrift::protocol;
//	using namespace ::apache::thrift::transport;
//	//using namespace ::apache::thrift::server;
//	//using namespace ::apache::thrift::concurrency;
//	using namespace apache::thrift;
//	using namespace apache::thrift::protocol;
//	using namespace apache::thrift::transport;
//	using boost::shared_ptr;
//	
//	printf("Hey yo love chump");
//
//	const char* filePath = GetResourceFilePath("config", "bin");
//	FILE* fp = fopen(filePath, "rt ");
//	assert(fp != nullptr);
//	fseek(fp, 0, SEEK_END);
//	size_t filesize = ftell(fp);
//	fseek(fp, 0, SEEK_SET);
//	void* buf = malloc(filesize+1);
//	printf("file is %d bytes", (int)filesize);
//	TMemoryBuffer* memoryBuffer = new TMemoryBuffer();
//	std::shared_ptr<apache::thrift::transport::TTransport> transport(memoryBuffer);
//	memoryBuffer->resetBuffer((uint8_t*)buf, (uint32_t)filesize);
//	filesize = fread(buf, 1, filesize+1, fp);
//	TProtocol* protocol = new TJSONProtocol(transport);
//	
//	mData = new Yoga::Config::Data;
//	assert(mData != nullptr);
//	mData->read(protocol);
//	
//	fclose(fp);
//	fp = nullptr;
//	free(buf);
//	buf = nullptr;
//	
//	delete protocol;
//	protocol = nullptr;
//}
//
//Config::~Config()
//{
//}
//
//int Config::GetNumSessions()
//{
//	return (int)mData->sessions.size();
//}
//
//const char* Config::GetSessionId(int n)
//{
//	return mData->sessions[n].sessionId.c_str();
//}
//
//const char* Config::GetSessionLocalizedName(int n)
//{
//	return mData->sessions[n].localizedName.c_str();
//}
//
//const char* Config::GetSessionSubtitle(int n)
//{
//	return mData->sessions[n].subtitle.c_str();
//}
//
//const char* Config::GetSessionCardImage(int n)
//{
//	return mData->sessions[n].cardImage.c_str();
//}
//
//const char* Config::GetSessionBackgroundImage(int n)
//{
//	return mData->sessions[n].backgroundImage.c_str();
//}
//
//bool Config::GetSessionComingSoon(int n)
//{
//	return mData->sessions[n].comingSoon;
//}
//
//int Config::GetSessionEnergyRating(int n)
//{
//	return mData->sessions[n].energyRating;
//}
//
//int Config::GetSessionNumPoses(int n)
//{
//	return (int)mData->sessions[n].poses.size();
//}
//
//const char* Config::GetSessionPoseEnglishName(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].englishName.c_str();
//}
//
//const char* Config::GetSessionPoseSanskritName(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].sanskritName.c_str();
//}
//
//int Config::GetSessionPoseSeconds(int sessionNum, int poseNum)
//{
//	return (int)mData->sessions[sessionNum].poses[poseNum].seconds;
//}
//
//const char* Config::GetSessionPosePoseFilename(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].poseFilename.c_str();
//}
//
//const char* Config::GetSessionPoseBackgroundFilename(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].backgroundFilename.c_str();
//}
//
//const char* Config::GetSessionPoseMatFilename(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].matFilename.c_str();
//}
//
//const char* Config::GetSessionPoseSwooshFilename(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].swooshFilename.c_str();
//}
//
//const char* Config::GetSessionPoseShadowFilename(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].shadowFilename.c_str();
//}
//
//const char* Config::GetSessionPoseShortAudioFilename(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].shortAudioFilename.c_str();
//}
//
//const char* Config::GetSessionPoseDetailAudioFilename(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].detailAudioFilename.c_str();
//}
//
//bool Config::GetSessionPoseFlipped(int sessionNum, int poseNum)
//{
//	return mData->sessions[sessionNum].poses[poseNum].flipped;
//}
//
//int Config::FindSessionNum(const char* sessionId)
//{
//	for (int32_t sessionNum=0; sessionNum<mData->sessions.size();  sessionNum++)
//	{
//		const char* sid = mData->sessions[sessionNum].sessionId.c_str();
//		if (!strcmp(sid, sessionId))
//		{
//			return sessionNum;
//		}
//	}
//	throw;
//}
//
////@end
