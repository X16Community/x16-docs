# Appendix XX: VERA firmware upgrade

| X16 Component | VERA          |
| Programmer    | TL866-3G/T48  |
| Software      | Xgpro         |
| Host OS       | Windows       |

## Before you start


## Programmer wiring

| VERA pin    | Connect to component | Connect to pin |
|-------------|----------------------|----------------|
| 1 +5V       | Not connected        | -              |
| 2 CDONE     | Not connected        | -              |
| 3 CRESET_B  | VERA                 | 8 GND          |
| 4 SPI_MISO  | TL866-3G/T48         | 5 MISO         |
| 5 SPI_MOSI  | TL866-3G/T48         | 15 MOSI        |
| 6 SPI_SCK   | TL866-3G/T48         | 7 SCK          |
| 7 SPI_SEL_N | TL866-3G/T48         | 1 /CS          |
| 8 GND       | TL866-3G/T48         | 16 GND         |


## Programmer software setup


## Powering the target component


## 