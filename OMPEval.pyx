# distutils: language = c++
# cython: c_string_type=unicode, c_string_encoding=utf8

from OMPEval cimport EquityCalculator
from OMPEval cimport CardRange
from libcpp.vector cimport vector

cdef class PyCardRange:
	cdef CardRange c_hr

	def __init__(self, hand_range):
		self.c_hr = CardRange(hand_range)

cdef class PyEquityCalculator:
	cdef EquityCalculator c_calc

	def set_time_limit(self, seconds):
		self.c_calc.setTimeLimit(seconds)

	def start(self, card_range, board_cards = None, dead_cards = None, enumerate_all = False, stdev_target = 5e-5,
			  update_interval = 0.2, thread_count = 0):
		cdef vector v[CardRange]
		kwargs = {}
		for i in card_range:
			v.push_back(CardRange(i))
		if board_cards:
			board = CardRange.getCardMask(board_cards)
		else:
			board = 0

		if dead_cards:
			dead = CardRange.getCardMask(dead_cards)
		else:
			dead = 0

		# cdef void function(Results) NULL

		#todo Finish making pointer work.
		return self.c_calc.start(v, board, dead, enumerate_all, stdev_target, NULL, update_interval, thread_count)

	def wait(self):
		self.c_calc.wait()

	def get_results(self):
		c_results = self.c_calc.getResults()
		results = {'players': c_results.players, 'equity': c_results.equity, 'wins': c_results.wins,
				   'ties': c_results.ties, 'wins_by_player_mask': c_results.winsByPlayerMask, 'hands': c_results.hands,
				   'interval_hands': c_results.intervalHands, 'speed': c_results.speed,
				   'interval_speed': c_results.intervalSpeed, 'time': c_results.time,
				   'interval_time': c_results.intervalTime, 'stdev': c_results.stdev,
				   'stdev_per_hand': c_results.stdevPerHand, 'progress': c_results.progress,
				   'preflop_combos': c_results.preflopCombos,
				   'evaluated_preflop_combos': c_results.evaluatedPreflopCombos, 'evaluations': c_results.evaluations,
				   'enumerate_all': c_results.enumerateAll, 'finished': c_results.finished}
		return results
