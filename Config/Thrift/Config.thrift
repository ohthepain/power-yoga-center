namespace java Yoga.Config
namespace py Yoga.Config
namespace cpp Yoga.Config

typedef i64 Timestamp

typedef string AssetID
typedef i32 SchemaVersionID
typedef string PoseEntryID
typedef string SessionID
typedef string LocalizedString
typedef string ResourceID
typedef string UpgradeInfoID

struct Settings
{
	1: required i32 schemaVersionId
	2: required i32 configVersionId
	10: required string minClientVersion
	11: required string pleaseUpdateVersion
}

struct UpgradeInfo
{
	1: required UpgradeInfoID upgradeInfoId
	10: required string minClientVersion
	11: required string pleaseUpdateVersion
}

struct PoseEntry
{
	1: required PoseEntryID poseEntryId
	2: required SessionID sessionId
	10: required string englishName
	11: required string sanskritName
	20: required i32 seconds
	30: required AssetID poseFilename
	31: required AssetID backgroundFilename
	32: required AssetID matFilename
	33: required AssetID swooshFilename
	34: required AssetID shadowFilename
	35: required AssetID shortAudioFilename
	36: required AssetID detailAudioFilename
	37: optional bool flipped
}

struct Session
{
	1: required SessionID sessionId
	10: required LocalizedString localizedName
	11: optional LocalizedString subtitle
	20: required ResourceID cardImage
	21: required ResourceID backgroundImage
	30: required i8 energyRating
	31: optional bool comingSoon
	// Populated by mutator
	40: optional list<PoseEntry> poses
}

typedef list<PoseEntryID> PoseSequence

struct Data
{
	1: required SchemaVersionID schemaVersionId
	# Removed by mutator
	10: optional list<PoseEntry> poses
	20: optional list<Session> sessions
}
