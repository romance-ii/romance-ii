all: dist

dist:
	rsync -Cravessh VioletVolts starhope@star-hope.org:star-hope.org/violet-volts/demo/

