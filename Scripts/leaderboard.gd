extends Control

var scores = []

class Ranking:
	var name: String
	var score: int
	
	func _init(n, s): 
		name = n
		score = s
	
	
func ranks_to_text(i):
	return scores[i].name + " - " + str(scores[i].score)

# Called when the node enters the scene tree for the first time.
func _ready():
	scores.append(Ranking.new("HERC", 3500))
	scores.append(Ranking.new("STAG", 2500))
	scores.append(Ranking.new("LADY", 1750))
	scores.append(Ranking.new("DUNG", 1000))
	scores.append(Ranking.new("LRVA", 500))
	#add_score(69)
	#ranks_to_console()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_score(player_score: int):
	for i in scores.size():
		if player_score >= scores[i].score:
			scores.insert(i, Ranking.new("YOU", player_score))
			populate_leaderboard(i)
			return
	scores.append(Ranking.new("YOU", player_score))
	populate_leaderboard(scores.size()-1)
	return
	
func populate_leaderboard(new):
	$Score1/Label.text = ranks_to_text(0)
	$Score2/Label.text = ranks_to_text(1)
	$Score3/Label.text = ranks_to_text(2)
	$Score4/Label.text = ranks_to_text(3)
	$Score5/Label.text = ranks_to_text(4)
	$Score6/Label.text = ranks_to_text(new)
