extends Node

var notePitchScales = []
var noteIndices = [0, 4, 7]

# enum note {C, Db, D, Eb, E, F, Gb, G, Ab, A, Bb, B}
#            -9 -8  -7 -6  -5 -4 -3  -2 -1  0   1  2
var chordType = ["maj", "min", "dim", "aug", "sus2", "sus4"]

export (bool) var test = false
export (int) var rootNote = -8
export (String) var currentChordType = "maj"
export (bool) var playChordProgression = true

func _ready():
	if test:
		__test()

func setUpAndPlayChord(root, type):
	notePitchScales = []
	currentChordType = type
	rootNote = root
	getNoteIndices()
	adjustForRoot()
	getPitchScales()
	setPitchScales()
	playChord()


func getNoteForIndex(index):
	return pow(2, (index as float / 12))


func getNoteIndices():
	match currentChordType:
		"maj":
			noteIndices = [0, 4, 7]
		"min":
			noteIndices = [0, 3, 7]
		"dim":
			noteIndices = [0, 3, 6]
		"aug":
			noteIndices = [0, 4, 8]
		"sus2":
			noteIndices = [0, 2, 7]
		"sus4":
			noteIndices = [0, 5, 7]


func adjustForRoot():
	for i in range(noteIndices.size()):
		noteIndices[i] += rootNote


func getPitchScales():
	notePitchScales.append(getNoteForIndex(noteIndices[0]))
	notePitchScales.append(getNoteForIndex(noteIndices[1]))
	notePitchScales.append(getNoteForIndex(noteIndices[2]))


func setPitchScales():
	$Note1.pitch_scale = notePitchScales[0]
	$Note2.pitch_scale = notePitchScales[1]
	$Note3.pitch_scale = notePitchScales[2]


func playChord():
	$Note1.play()
	$Note2.play()
	$Note3.play()


func debugPrintNoteInfo():
	print('note indices: ', noteIndices)
	print('note pitch scales: ', notePitchScales)


func play_I_IV_V_I():
	var noteDelay = 0.5
	var root = rootNote
	setUpAndPlayChord(root, "maj")
	yield(get_tree().create_timer(noteDelay), "timeout")
	setUpAndPlayChord(root - 7, "maj")
	yield(get_tree().create_timer(noteDelay), "timeout")
	setUpAndPlayChord(root -5, "maj")
	yield(get_tree().create_timer(noteDelay), "timeout")
	setUpAndPlayChord(root, "maj")


func __test():
	if (playChordProgression):
		play_I_IV_V_I()
	else:
		setUpAndPlayChord(rootNote, currentChordType)
