def CreateSessionsTable(data):
	print("Hi from CreateSessionsTable mutator")

	sessions = {}
	for session in Data.sessions:
		sessions[session.sessionId] = session

	for poseEntry in Data.poses:
		print(poseEntry.sessionId)
		session = sessions[poseEntry.sessionId]
		print("-->" + session.sessionId)
		if session.poses == None:
			print("create session.poses")
			session.poses = []
		session.poses.append(poseEntry)

	Data.poses = None
