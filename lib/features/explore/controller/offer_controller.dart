import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/features/explore/repository/offer_repository.dart';
import 'package:tcean/models/coupon_model.dart';

final offerControllerProvider = Provider<OfferController>((ref) {
  return OfferController(
      offerRepository: ref.read(offerRepositoryProvider), ref: ref);
});

final getOffersProvider = StreamProvider<List<CouponModel>?>((ref) {
  final offerController = ref.watch(offerControllerProvider);
  return offerController.getOffers();
});

class OfferController {
  final OfferRepository _offerRepository;
  final Ref _ref;

  OfferController({required OfferRepository offerRepository, required Ref ref})
      : _offerRepository = offerRepository,
        _ref = ref;

  Stream<List<CouponModel>> getOffers() {
    return _offerRepository.getOffersData();
  }
}
