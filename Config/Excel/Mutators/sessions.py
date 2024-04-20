def CreateSessionsTable(data):
	print("Hi from CreateSessionsTable mutator")

	if data.poses == None:
		print("Data.poses is None - already mutated?")
		return

	sessions = {}
	for session in data.sessions:
		sessions[session.sessionId] = session

	for poseEntry in data.poses:
		session = sessions[poseEntry.sessionId]
		if session.poses == None:
			session.poses = []
		session.poses.append(poseEntry)

	data.poses = None

__mutators = [CreateSessionsTable]
