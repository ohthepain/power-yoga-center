//
//  Config.h
//  Yoga
//
//  Created by Paul Wilkinson on 1/17/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

#ifndef Config_h
#define Config_h

namespace Yoga
{
	namespace Config
	{
		class Data;
	}
}

#if defined __cplusplus
extern "C" {
#endif
	void ConfigInit();
	void ConfigShutdown();
	int GetNumSessions();
	const char* GetSessionId(int n);
	const char* GetSessionLocalizedName(int n);
	int GetSessionNumPoses(int n);
	const char* GetSessionCardImage(int n);
	const char* GetSessionBackgroundImage(int n);
	int GetSessionEnergyRating(int n);
	bool GetSessionComingSoon(int n);
	
	const char* GetSessionPoseEnglishName(int sessionNum, int poseNum);
	const char* GetSessionSubtitle(int sessionNum);
	const char* GetSessionPoseSanskritName(int sessionNum, int poseNum);
	int GetSessionPoseSeconds(int sessionNum, int poseNum);
	const char* GetSessionPosePoseFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseBackgroundFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseMatFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseSwooshFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseShadowFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseShortAudioFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseDetailAudioFilename(int sessionNum, int poseNum);
	bool GetSessionPoseFlipped(int sessionNum, int poseNum);
	int FindSessionNum(const char* sessionId);
#if defined __cplusplus
}
#endif

class Config
{
public:
	static void Init();
	static void Shutdown();
	static Config* GetInstance() { return mInstance; }
	
	int GetNumSessions();
	const char* GetSessionId(int n);
	const char* GetSessionLocalizedName(int n);
	const char* GetSessionSubtitle(int sessionNum);
	int GetSessionNumPoses(int n);
	const char* GetSessionCardImage(int n);
	const char* GetSessionBackgroundImage(int n);
	int GetSessionEnergyRating(int n);
	bool GetSessionComingSoon(int n);

	const char* GetSessionPoseEnglishName(int sessionNum, int poseNum);
	const char* GetSessionPoseSanskritName(int sessionNum, int poseNum);
	int GetSessionPoseSeconds(int sessionNum, int poseNum);
	const char* GetSessionPosePoseFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseBackgroundFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseMatFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseSwooshFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseShadowFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseShortAudioFilename(int sessionNum, int poseNum);
	const char* GetSessionPoseDetailAudioFilename(int sessionNum, int poseNum);
	bool GetSessionPoseFlipped(int sessionNum, int poseNum);
	int FindSessionNum(const char* sessionId);
	
private:
	Config();
	virtual ~Config();
	
	static Config* mInstance;
	
	Yoga::Config::Data* mData;
};

/*
#import <Foundation/Foundation.h>

@interface Config : NSObject

//@property (strong, nonatomic) id someProperty;

- (void) initConfig;
- (int) getNumPoses;
- (int) getNumSessions;

@end
*/
#endif /* Config_h */
