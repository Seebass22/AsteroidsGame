extends Node2D

var notePitchScales = []
var noteIndices = [0, 4, 7]

enum chordType {MAJ, MIN, DIM, AUG}
export (chordType) var currentChordType = chordType.MIN

func _ready():
	getNoteIndices()
	getPitchScales()
	setPitchScales()
	playChord()

	print(noteIndices[0])
	print(noteIndices[1])
	print(noteIndices[2])

	print(notePitchScales[0])
	print(notePitchScales[1])
	print(notePitchScales[2])

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
