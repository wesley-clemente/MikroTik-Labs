# MikroTik Labs 🛠️🌐

Repositório dedicado ao armazenamento de scripts (`.rsc`), laboratórios práticos e configurações de roteadores **MikroTik RouterOS**.

---

## 📂 Projeto 1: Roteador de Borda Básico (`projeto1_roteador_basico.rsc`)

Configuração inicial limpa para transformar uma RouterBOARD em um gateway doméstico ou corporativo básico, recebendo internet via DHCP na porta 1 e distribuindo rede local estruturada nas demais portas.

### 🔧 Ambiente Homologado
* **Equipamento:** MikroTik RB450
* **Sistema:** RouterOS v7.25.1
* **Fuso Horário:** `America/Sao_Paulo`

### 🗺️ Topologia e Endereçamento

| Interface / Grupo | Função | Configuração de Rede | Observações |
| :--- | :--- | :--- | :--- |
| **`ether1`** | WAN (Internet) | DHCP Client | Recebe IP dinâmico da operadora/modem |
| **`BRIDGE - LAN`** | Rede Local | `192.168.88.1/24` | Agrupa as portas físicas `ether2` até `ether5` |
| **DHCP Server (`dhcp1`)** | Distribuição IP | Pool: `192.168.88.2` – `192.168.88.254` | Gateway: `192.168.88.1` / DNS: `8.8.8.8`, `1.1.1.1` |

### ⚙️ O que este script configura
1. **Bridge Local (`BRIDGE - LAN`):** Unifica as portas `ether2`, `ether3`, `ether4` e `ether5` no mesmo domínio de broadcast (funcionando como switch para a rede interna).
2. **Conectividade WAN:** Habilita o *DHCP Client* na interface `ether1` para obter link de internet automaticamente.
3. **Servidor DHCP Completo:** Cria o pool de endereços, define a rede `192.168.88.0/24` e entrega IPs automaticamente junto com os servidores DNS públicos do Google e da Cloudflare.
4. **NAT (Masquerade):** Aplica mascaramento de saída (`srcnat`) na `ether1`, permitindo que os dispositivos da rede interna naveguem na internet compartilhando o IP da WAN.
5. **Serviço de DNS:** Habilita resolução remota (`allow-remote-requests=yes`) para atuar como cache DNS caso solicitado.

---

## 🚀 Como importar a configuração no MikroTik

> **⚠️ Aviso de Segurança:** Este laboratório foca apenas em conectividade básica (Camadas 2 e 3). Ele **não inclui regras de Firewall Filter**. Antes de expor o equipamento diretamente a um IP público na `ether1`, adicione regras na `chain=input` bloqueando acessos externos não solicitados (especialmente na porta 53/DNS e portas de gerência como Winbox/SSH).

### Opção 1: Via Winbox + Terminal
1. Acesse o MikroTik pelo **Winbox** e abra o menu **Files**.
2. Arraste o arquivo `projeto1_roteador_basico.rsc` do seu computador para dentro da janela **Files**.
3. Abra o **New Terminal** e aplique o script em um roteador limpo (sem configuração padrão):
   ```routeros
   /import file-name=projeto1_roteador_basico.rsc
   ```

### Opção 2: Aplicação em Reset Limpo (Recomendado)
Para zerar o equipamento removendo qualquer configuração antiga e já carregar este arquivo automaticamente na reinicialização (com o arquivo já dentro de *Files*):
```routeros
/system reset-configuration no-defaults=yes run-after-reset=projeto1_roteador_basico.rsc
```
