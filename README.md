# PyOMP

This is a fork of the abandoned OMPEval project, an extremely fast Texas Hold'em hand evaluator written by zekyll in C++, now wrapped in Python.

# Quick start

I'm in the very early stages but the package can be built and run using
```
python setup.py build_ext --inplace
```

```python
import OMPEval
print('start')
eq = OMPEval.PyEquityCalculator()
eq.set_time_limit(.1)
eq.start([b'2c8h', b'2s8d'])
eq.wait()
results = eq.get_results()
for key, value in results.items():
	print(key, value)

print('finished')
```