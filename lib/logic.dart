class FuelLogic {
  // Розрахунок для Завдання 1
  static Map<String, double> calculateTask1({
  required double cp, required double hp, required double sp,
  required double np, required double op, required double wp, required double ap,
  }) {
  // Коефіцієнти переходу
  double kPc = 100 / (100 - wp);
  double kPg = 100 / (100 - wp - ap);

  // Склад сухої маси (%)
  double hc = hp * kPc, cc = cp * kPc, sc = sp * kPc, nc = np * kPc, oc = op * kPc, ac = ap * kPc;

  // Склад горючої маси (%)
  double hg = hp * kPg, cg = cp * kPg, sg = sp * kPg, ng = np * kPg, og = op * kPg;

  // Нижча теплота згоряння для робочої маси (МДж/кг)
  double qph = (339 * cp + 1030 * hp - 108.8 * (op - sp) - 25 * wp) / 1000.0;

  // Перерахунок теплоти на суху та горючу маси
  double qch = (qph + 0.025 * wp) * (100 / (100 - wp));
  double qgh = (qph + 0.025 * wp) * (100 / (100 - wp - ap));

  return {'qph': qph, 'qch': qch, 'qgh': qgh, 'hc': hc, 'cc': cc, 'sc': sc, 'nc': nc, 'oc': oc, 'ac': ac, 'hg': hg, 'cg': cg, 'sg': sg, 'ng': ng, 'og': og};
  }

  // Розрахунок для Завдання 2 (Мазут)
  static Map<String, double> calculateTask2({
  required double cg, required double hg, required double og,
  required double sg, required double qg, required double wp,
  required double ad, required double v,
  }) {
  // Зола на робочу масу
  double ap = ad * (100 - wp) / 100;

  // Коефіцієнт перерахунку
  double factor = (100 - wp - ap) / 100;

  // Склад робочої маси (%)
  double cp = cg * factor, hp = hg * factor, op = og * factor, sp = sg * factor, vp = v * (100 - wp) / 100;

  // Теплота згоряння на робочу масу (МДж/кг)
  double qph = qg * (100 - wp - ap) / 100 - 0.025 * wp;

  return {'cp': cp, 'hp': hp, 'op': op, 'sp': sp, 'ap': ap, 'vp': vp, 'qph': qph};
  }
}