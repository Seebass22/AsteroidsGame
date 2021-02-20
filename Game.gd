extends Node2D

var notePitchScales = []
var noteIndices = [0, 4, 7]

# enum note {C, Db, D, Eb, E, F, Gb, G, Ab, A, Bb, B}
#            -9 -8  -7 -6  -5 -4 -3  -2 -1  0   1  2
enum chordType {MAJ, MIN, DIM, AUG}

export (int) var rootNote = -8
export (chordType) var currentChordType = chordType.MIN
export (bool) var playChordProgression = true

func _ready():
	if (playChordProgression):
		play_I_IV_V_I()
	else:
		setUpAndPlayChord(rootNote, currentChordType)


func setUpAndPlayChord(root, type):
	notePitchScales = []
	currentChordType = type
	rootNote = root
	getNoteIndices()
	adjustForRoot()
	getPitchScales()
	setPitchScales()
	debugPrintNoteInfo()
	playChord()


func getNoteForIndex(index):
	return pow(2, (index as float / 12))


func getNoteIndices():
	match currentChordType:
		chordType.MAJ:
			noteIndices = [0, 4, 7]
		chordType.MIN:
			noteIndices = [0, 3, 7]
		chordType.DIM:
			noteIndices = [0, 3, 6]
		chordType.AUG:
			noteIndices = [0, 4, 8]


func adjustForRoot():
	for i in range(noteIndices.size()):
		noteIndices[i] += rootNote


func getPitchScales():
	notePitchScales.append(getNoteForIndex(noteIndices[0]))
	notePitchScales.append(getNoteForIndex(noteIndices[1]))
	notePitchScales.append(getNoteForIndex(noteIndices[2]))


func setPitchScales():
	$Sound/Note1.pitch_scale = notePitchScales[0]
	$Sound/Note2.pitch_scale = notePitchScales[1]
	$Sound/Note3.pitch_scale = notePitchScales[2]


func playChord():
	$Sound/Note1.play()
	$Sound/Note2.play()
	$Sound/Note3.play()


func debugPrintNoteInfo():
	print('note indices: ', noteIndices)
	print('note pitch scales: ', notePitchScales)


func play_I_IV_V_I():
	var noteDelay = 0.5
	var root = rootNote
	setUpAndPlayChord(root, chordType.MAJ)
	yield(get_tree().create_timer(noteDelay), "timeout")
	setUpAndPlayChord(root - 7, chordType.MAJ)
	yield(get_tree().create_timer(noteDelay), "timeout")
	setUpAndPlayChord(root -5, chordType.MAJ)
	yield(get_tree().create_timer(noteDelay), "timeout")
	setUpAndPlayChord(root, chordType.MAJ)
