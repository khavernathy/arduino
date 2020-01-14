import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import datetime

plt.rcParams.update({'font.size': 10})
temp_unit = 'F' # 'K'

# first the temperature plot
#plt.plot_date(dates, T)
fig, ax = plt.subplots() #figsize=(8,4))
#plt.gcf().autofmt_xdate()

for filename in ['T_hu.dat', 'T_th.dat', 'T_wa.dat']:
    print "Making graph for " + filename + " ..."
    data = np.genfromtxt(filename, dtype='str')
    date = data[:,0]
    time = data[:,1]
    dt = np.column_stack((date,time))
    tmp = data[:,2]
    x = np.array([])
    for i in tmp:
        if (temp_unit == 'F'):
            x = np.append(x, float(i))
        elif (temp_unit == 'C'):
            x = np.append(x, (5.0/9.0)*(float(i)-32.0))
        elif (temp_unit == 'K'):
            x = np.append(x, (5.0/9.0)*(float(i)-32.0) + 273.15)


    dates = np.array([])

    for idx,i in enumerate(dt):
        di = i[0].split("-")
        if (len(di[1])  < 2): 
            di[1] = "0" + di[1]
        if (len(di[2]) < 2):
            di[2] = "0" + di[2]

        ti = i[1].split(":")
        if (len(ti[0]) < 2):
            ti[0] = "0" + ti[0]
        if (len(ti[1]) < 2):
            ti[1] = "0" + ti[1]
        if (len(ti[2]) < 2):
            ti[2] = "0" + ti[2]
        
        i = di[0]+'-'+di[1]+'-'+di[2]+' '+ti[0]+':'+ti[1]+':'+ti[2]
        thing = datetime.datetime.strptime(i, '%Y-%m-%d %H:%M:%S')
        dates = np.append(dates,thing)

    dates = matplotlib.dates.date2num(dates)


    ax.plot(dates,x, label=filename)
myFmt = matplotlib.dates.DateFormatter('%m-%d %H:%M')
ax.xaxis.set_major_formatter(myFmt)
ax.grid(True)
ax.legend(loc=3)
ax.set_title('Temperatures')
fig.autofmt_xdate()
plt.xlabel('Time')
plt.ylabel('Temperature (' + temp_unit + ')')
plt.savefig('T' + '.dat.png')


# now individual graphs
for filename in ['RH.dat', 'light.dat']:
    print "Making graph for " + filename + " ..."
    data = np.genfromtxt(filename, dtype='str')
    date = data[:,0]
    time = data[:,1]
    dt = np.column_stack((date,time))
    tmp = data[:,2]
    x = np.array([])
    for i in tmp:
        x = np.append(x, float(i))


    dates = np.array([])

    for idx,i in enumerate(dt):
        di = i[0].split("-")
        if (len(di[1])  < 2): 
            di[1] = "0" + di[1]
        if (len(di[2]) < 2):
            di[2] = "0" + di[2]

        ti = i[1].split(":")
        if (len(ti[0]) < 2):
            ti[0] = "0" + ti[0]
        if (len(ti[1]) < 2):
            ti[1] = "0" + ti[1]
        if (len(ti[2]) < 2):
            ti[2] = "0" + ti[2]
        
        i = di[0]+'-'+di[1]+'-'+di[2]+' '+ti[0]+':'+ti[1]+':'+ti[2]
        thing = datetime.datetime.strptime(i, '%Y-%m-%d %H:%M:%S')
        dates = np.append(dates,thing)

    dates = matplotlib.dates.date2num(dates)
    #plt.plot_date(dates, T)
    fig, ax = plt.subplots() #figsize=(8,4))
    ax.plot(dates,x)
    #plt.gcf().autofmt_xdate()
    myFmt = matplotlib.dates.DateFormatter('%m-%d %H:%M')
    ax.xaxis.set_major_formatter(myFmt)
    ax.grid(True)
    ax.set_title(filename)
    fig.autofmt_xdate()

    plt.xlabel('Time')
    if (filename == 'RH.dat'):
        plt.ylabel('Relative Humidity (%)')
    elif (filename == 'light.dat'):
        plt.ylabel('Light (a.u.)')

    plt.savefig(filename + '.png')
