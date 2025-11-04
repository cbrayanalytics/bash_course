### Goal:
Build a comprehensive weather reporting tool named `weather.sh` that fetches data from weather APIs and displays beautifully formatted forecasts.
### Requirements:

**Core Features:**
- Current weather conditions
- 7-day forecast
- Hourly forecast
- Weather alerts
- Multiple location support
- Temperature units (F/C)
- Wind speed units
- UV index
- Air quality

**Data Sources:**
- OpenWeatherMap API
- WeatherAPI
- National Weather Service
- Multiple API fallback

**Display Options:**
- Terminal output (formatted)
- ASCII weather icons
- Color-coded temperatures
- Charts and graphs
- Export to file
### Expected Output Example:
```bash
./weather.sh --location "Denver, CO"
```

```
╔════════════════════════════════════════════════════════════════╗
║              WEATHER REPORT                                    ║
║              Denver, Colorado                                  ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Fetching weather data...
[INFO] API: OpenWeatherMap
[INFO] Location: Denver, CO (39.7392°N, 104.9903°W)

Current Conditions
════════════════════════════════════════════════════════════════
Updated: Monday, October 20, 2025, 12:21 AM MDT

    \   /     Partly Cloudy
     .-.      🌡️  Temperature:  52°F (11°C)
  ― (   ) ―   🌡️  Feels Like:   48°F (9°C)
     `-'      💧 Humidity:     45%
    /   \     💨 Wind:         8 mph NW
              🌧️  Precipitation: 0%
              👁️  Visibility:   10 mi
              🔆 UV Index:     0 (Low)
              🌅 Sunrise:      6:54 AM
              🌇 Sunset:       6:32 PM

Weather: Partly cloudy skies. Comfortable temperatures.

Air Quality: Good (AQI: 42)
────────────────────────────────────────────────────────────────
PM2.5: 10 μg/m³ | PM10: 15 μg/m³ | O₃: 25 ppb

7-Day Forecast
════════════════════════════════════════════════════════════════

Mon 10/20    \  /       Partly Cloudy      ⬆️ 68°F  ⬇️ 45°F   💧 10%
             ― ○ ―      Clear evening      💨 5-10 mph

Tue 10/21      ☀️        Sunny             ⬆️ 72°F  ⬇️ 48°F   💧 0%
                        Perfect day!       💨 3-8 mph

Wed 10/22    \ | /      Mostly Sunny       ⬆️ 70°F  ⬇️ 50°F   💧 5%
              ―○―       Mild weather       💨 5-12 mph
              / | \

Thu 10/23      ☁️        Cloudy            ⬆️ 65°F  ⬇️ 48°F   💧 20%
                        Overcast skies     💨 8-15 mph

Fri 10/24     ⛈️        Thunderstorms     ⬆️ 62°F  ⬇️ 45°F   💧 80%
              ⚡ 🌧️      Heavy rain         💨 10-20 mph
                        ⚠️  Severe weather alert

Sat 10/25    🌧️ 🌧️      Rain              ⬆️ 58°F  ⬇️ 42°F   💧 70%
                        Rainy day          💨 8-15 mph

Sun 10/26    \  /       Partly Cloudy      ⬆️ 64°F  ⬇️ 44°F   💧 30%
             ― ○ ―      Clearing up        💨 5-10 mph

Hourly Forecast (Next 24 Hours)
════════════════════════════════════════════════════════════════

Time        Temp    Condition       Rain    Wind
────────────────────────────────────────────────────────────────
01:00 AM    52°F    Partly Cloudy   0%      8 mph NW
02:00 AM    51°F    Partly Cloudy   0%      7 mph NW
03:00 AM    50°F    Partly Cloudy   0%      6 mph NW
04:00 AM    49°F    Mostly Clear    0%      5 mph NW
05:00 AM    48°F    Clear           0%      5 mph NW
06:00 AM    47°F    Clear           0%      4 mph W
07:00 AM    48°F    Clear           0%      4 mph W
08:00 AM    52°F    Sunny           0%      5 mph W
09:00 AM    56°F    Sunny           0%      6 mph W
10:00 AM    60°F    Sunny           0%      7 mph W
11:00 AM    64°F    Sunny           0%      8 mph W
12:00 PM    67°F    Sunny           0%      9 mph W
[... continues for 24 hours]

Temperature Trend (Next 24 Hours)
════════════════════════════════════════════════════════════════

70°F ┤                            ╭╮
65°F ┤                        ╭───╯╰─╮
60°F ┤                   ╭────╯      ╰─╮
55°F ┤              ╭────╯              ╰─╮
50°F ┤         ╭────╯                     ╰──╮
45°F ┤    ╭────╯                             ╰───
40°F ┼────╯
     └┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬
      12A 4A 8A 12P 4P 8P 12A 4A 8A 12P

Weather Alerts
════════════════════════════════════════════════════════════════

⚠️  SEVERE WEATHER ALERT

Thunderstorm Watch
────────────────────────────────────────────────────────────────
Issued:    Oct 19, 2025 10:00 PM MDT
Expires:   Oct 20, 2025 6:00 AM MDT
Severity:  Moderate
Area:      Denver Metro Area

Description:
Scattered thunderstorms expected late Thursday evening through
Friday morning. Some storms may be severe with heavy rain, gusty
winds up to 40 mph, and small hail. Localized flooding possible.

Recommended Actions:
  • Monitor weather conditions
  • Secure outdoor items
  • Avoid unnecessary travel Thursday evening
  • Have emergency kit ready

Additional Information
════════════════════════════════════════════════════════════════

Location Details:
────────────────────────────────────────────────────────────────
City:            Denver
State:           Colorado
Country:         United States
Coordinates:     39.7392°N, 104.9903°W
Elevation:       5,280 ft (1,609 m)
Timezone:        America/Denver (MDT, UTC-6)
Population:      ~715,000

Climate:
────────────────────────────────────────────────────────────────
Type:            Semi-arid
Annual Rainfall: ~15 inches
Annual Snowfall: ~60 inches
Avg High:        64°F (18°C)
Avg Low:         37°F (3°C)

Records:
────────────────────────────────────────────────────────────────
Highest Temp:    105°F (Aug 8, 1878)
Lowest Temp:     -29°F (Jan 9, 1875)
Most Rain (24h): 4.5 inches (May 28, 2002)
Most Snow (24h): 23.8 inches (Mar 23, 2003)

╔════════════════════════════════════════════════════════════════╗
║                    WEATHER SUMMARY                             ║
╚════════════════════════════════════════════════════════════════╝

Today:  Partly cloudy with temperatures in the mid-60s. Light 
        winds from the northwest. Good conditions for outdoor 
        activities.

Tonight: Clear skies with temperatures dropping to the mid-40s.
         Light winds. Comfortable evening.

Tomorrow: Sunny and pleasant with highs near 72°F. Perfect 
          weather for outdoor plans.

Week Outlook: Generally mild with a storm system moving in 
              Thursday night into Friday. Heavy rain and 
              thunderstorms expected. Clearing by the weekend.

Best Days This Week: Tuesday, Wednesday (Sunny, 70-72°F)
Worst Day: Friday (Thunderstorms, 80% rain chance)

────────────────────────────────────────────────────────────────
Data source: OpenWeatherMap
Last updated: 2025-10-20 00:21:00 MDT
Next update: 2025-10-20 01:21:00 MDT

Save this report: ./weather.sh --location "Denver" --save
Set location default: ./weather.sh --set-default "Denver"
Check different location: ./weather.sh --location "Boulder"
```

```bash
./weather.sh --location "Denver" --forecast hourly --hours 12
```

```
╔════════════════════════════════════════════════════════════════╗
║              12-HOUR FORECAST - Denver, CO                     ║
╚════════════════════════════════════════════════════════════════╝

Monday, October 20, 2025

Hour      Temp    Feels  Condition      Rain   Wind    Humidity
────────────────────────────────────────────────────────────────
01:00 AM  52°F    48°F   Partly Cloudy  0%     8 mph   45%  🌙
02:00 AM  51°F    47°F   Partly Cloudy  0%     7 mph   46%  🌙
03:00 AM  50°F    46°F   Partly Cloudy  0%     6 mph   48%  🌙
04:00 AM  49°F    45°F   Mostly Clear   0%     5 mph   50%  🌙
05:00 AM  48°F    44°F   Clear          0%     5 mph   52%  🌙
06:00 AM  47°F    43°F   Clear          0%     4 mph   54%  🌙
07:00 AM  48°F    45°F   Clear          0%     4 mph   52%  🌅
08:00 AM  52°F    49°F   Sunny          0%     5 mph   48%  ☀️
09:00 AM  56°F    54°F   Sunny          0%     6 mph   42%  ☀️
10:00 AM  60°F    58°F   Sunny          0%     7 mph   38%  ☀️
11:00 AM  64°F    62°F   Sunny          0%     8 mph   34%  ☀️
12:00 PM  67°F    66°F   Sunny          0%     9 mph   30%  ☀️

Temperature Range: 47°F - 67°F (20° spread)
Warmest: 12:00 PM (67°F)
Coolest: 06:00 AM (47°F)
```

```bash
./weather.sh --location "40.0150,-105.2705" --units metric
```

```
╔════════════════════════════════════════════════════════════════╗
║              WEATHER REPORT (METRIC)                           ║
║              Boulder, Colorado                                 ║
╚════════════════════════════════════════════════════════════════╝

Current Conditions
════════════════════════════════════════════════════════════════

    \   /     Partly Cloudy
     .-.      
  ― (   ) ―   🌡️  Temperature:  10°C
     `-'      🌡️  Feels Like:   8°C
    /   \     💧 Humidity:     48%
              💨 Wind:         13 km/h NW
              🌧️  Precipitation: 0%

7-Day Forecast
════════════════════════════════════════════════════════════════

Mon 10/20    Partly Cloudy      ⬆️ 20°C  ⬇️ 7°C    💧 10%
Tue 10/21    Sunny             ⬆️ 22°C  ⬇️ 9°C    💧 0%
Wed 10/22    Mostly Sunny       ⬆️ 21°C  ⬇️ 10°C   💧 5%
Thu 10/23    Cloudy            ⬆️ 18°C  ⬇️ 9°C    💧 20%
Fri 10/24    Thunderstorms     ⬆️ 17°C  ⬇️ 7°C    💧 80%
Sat 10/25    Rain              ⬆️ 14°C  ⬇️ 6°C    💧 70%
Sun 10/26    Partly Cloudy      ⬆️ 18°C  ⬇️ 7°C    💧 30%
```

**Additional features:**
```bash
# Save default location
./weather.sh --set-default "Denver, CO"

# Compare two locations
./weather.sh --compare "Denver,CO" "Boulder,CO"

# Show moon phase
./weather.sh --moon

# Historical weather
./weather.sh --historical --date "2025-10-01"

# Export to file
./weather.sh --export weather_report.txt
./weather.sh --export weather.html --format html
./weather.sh --export weather.json --format json
```