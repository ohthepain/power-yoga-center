namespace java Yoga.Config
namespace py Yoga.Config
namespace cpp Yoga.Config

include "shared.thrift"

typedef i64 Timestamp

typedef string AssetID
typedef i32 SchemaVersionID
typedef string PoseEntryID
typedef string PoseSequenceID

struct PoseEntry
{
	1: required PoseEntryID poseEntryId
	10: required string englishName
	11: required string realName
	20: required i32 seconds
	30: required AssetID poseFilename
	31: required AssetID backgroundFilename
	32: required AssetID matFilename
	33: required AssetID swooshFilename
	34: required AssetID shadowFilename
	35: required AssetID shortAudioFilename
	36: required AssetID detailAudioFilename
}

typedef list<PoseEntryID> PoseSequence

struct Data
{
	1: required SchemaVersionID schemaVersionId
	10: optional map<PoseEntryID, PoseEntry> poseEntries
	20: optional map<PoseSequenceID, PoseSequence> poseSequences
}
