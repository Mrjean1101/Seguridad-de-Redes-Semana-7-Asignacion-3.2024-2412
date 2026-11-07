# Tarea Semana 7 (Asignacion 3) - Monitoreo SNMP con Zabbix

**Autor:** Jean Heriberto Alvarez Sierra  
**Matrícula:** 2024-2412  
**Enlace del Video Demostrativo: https://youtu.be/Gb5HHEkXGwM

## Diagrama de la Topologia

```
+-------------------------------------------------+
|                Servidor Zabbix                  |
|      (Ubuntu Server 20.04 / Zabbix 6.0 LTS)     |
|             IP: 10.24.12.12/24 (DHCP)           |
+-------------------------------------------------+
                        |
                        | (ens34 / VMnet3)
                        |
                        | (Gi0/1)
+-------------------------------------------------+
|                Switch Cisco L2                  |
|          (Cliente SNMP / SVI Vlan 1)            |
|               IP: 10.24.12.2/24                 |
+-------------------------------------------------+
                        |
                        | (Gi0/0)
                        |
                        | (e2/0)
+-------------------------------------------------+
|              Router Cisco (C7200)               |
|      (Servidor DHCP / Cliente SNMP / Gateway)   |
|               IP: 10.24.12.1/24                 |
+-------------------------------------------------+
```

## 🎯 1. Propósito del Laboratorio

Diseñar, configurar y validar una infraestructura de monitoreo de red utilizando el protocolo SNMP (Simple Network Management Protocol). 

Se implementa un servidor Zabbix en Ubuntu Server 20.04 para recopilar telemetría en tiempo real desde un Router y un Switch Cisco. La asignación de direccionamiento IP y la configuración del entorno de red se realiza de manera dinámica mediante un servidor DHCP configurado en el router, utilizando un esquema de direccionamiento basado en la matrícula del estudiante.

### Tabla de Direccionamiento
| Dispositivo | Interfaz | Dirección IP | Máscara de Red | Función |
| :--- | :--- | :--- | :--- | :--- |
| **Servidor Zabbix (Ubuntu)** | ens34 | `10.24.12.12` (DHCP) | `255.255.255.0` | Servidor de Monitoreo / Cliente DHCP |
| **Switch Cisco L2** | Vlan 1 | `10.24.12.2` | `255.255.255.0` | Cliente SNMP |
| **Router Cisco (C7200)** | Ethernet2/0 | `10.24.12.1` | `255.255.255.0` | Servidor DHCP / Gateway / Cliente SNMP |

---

## ⚙️ 2. Requisitos Implementados

### A. Enrutamiento y Direccionamiento Dinámico (Router Cisco)
* **Servidor DHCP:** Se configuró un pool de DHCP (`POOL_LAN_ZABBIX`) en el router para asignar direcciones IP dinámicamente a la red LAN (`10.24.12.0/24`), excluyendo las direcciones estáticas utilizadas por la infraestructura de red.

### B. Infraestructura de Monitoreo (Zabbix y SNMP)
* **Comunidad SNMP:** Se configuró la comunidad SNMP de solo lectura (`RO`) con el valor `Zabbix2412` tanto en el Router como en el Switch Cisco.
* **Cliente DHCP en Ubuntu:** Se ajustó la configuración de red (`Netplan`) en el servidor Ubuntu para recibir una dirección IP dinámica en la interfaz conectada a la red de PNETLab, manteniendo el enrutamiento correcto hacia internet.
* **Validación de Monitoreo:** Se añadieron los dispositivos Cisco al panel de Zabbix y se verificó la recolección exitosa de datos SNMP en tiempo real (visibilidad de métricas en *Latest data* y conectividad en verde en *Availability*).

---

## 📁 3. Archivos y Recursos del Repositorio
* **Running-Configs:**
  * [Router C7200 Running Config](Router_RunningConfig.txt)
  * [Switch L2 Running Config](Switch_RunningConfig.txt)
* **Scripts Utilizados:**
  * [Scripts de Configuración CLI y Netplan]
* **Documentación Visual:**
  * Capturas de la topología en PNETLab.
  * Capturas del panel de monitoreo de Zabbix (Hosts Availability y Latest Data).
