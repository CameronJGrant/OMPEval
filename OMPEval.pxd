from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp cimport bool

cdef extern from "omp/EquityCalculator.cpp":
    pass
cdef extern from "omp/CardRange.cpp":
    pass
cdef extern from "omp/CombinedRange.cpp":
    pass
cdef extern from "omp/HandEvaluator.cpp":
    pass
cdef extern from "omp/CombinedRange.h":
    pass
cdef extern from "omp/HandEvaluator.h":
    pass

cdef extern from "stdint.h":
    ctypedef unsigned long long uint64_t

cdef extern from "omp/CardRange.h" namespace "omp":
    cdef cppclass CardRange:
        CardRange() except +
        CardRange(string & text)
        @staticmethod
        uint64_t getCardMask(const string & text)


cdef extern from "omp/EquityCalculator.h" namespace "omp":
    cdef cppclass EquityCalculator:
        EquityCalculator() except +
        struct Results:
            unsigned players
            double equity[6]
            uint64_t wins[6]
            double ties[6]
            uint64_t winsByPlayerMask[6]
            uint64_t hands, intervalHands
            double speed, intervalSpeed
            double time, intervalTime
            double stdev
            double stdevPerHand
            double progress
            uint64_t preflopCombos
            uint64_t skippedPreflopCombos
            uint64_t evaluatedPreflopCombos
            uint64_t evaluations
            bool enumerateAll
            bool finished
        void setTimeLimit(double seconds)
        bool start(vector[CardRange] handRanges,
                   uint64_t boardCards,
                   uint64_t deadCards,
                   bool enumerateAll,
                   double stdevTarget,
                   # FPtr,
                   # double updateInterval,
                   # unsigned threadCount
                   )
        void wait()
        Results getResults()

