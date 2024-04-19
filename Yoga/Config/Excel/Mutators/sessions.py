
def CreateSessionsTable(data):
	print("Hi from CreateSessionsTable mutator")
    for poseId in data.poses:
        pose = data.poses[poseId]
        sessionId = pose.sessionId
        session = data.sessions[sessionId]
        if session.poses == nil:
            session.poses = {}
        session.poses.append(pose)
