import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/app_text_style.dart';
import '../../../auth/widgets/Cusstom_btn.dart';
import '../../../auth/widgets/custom_keypad.dart';
import '../../data/models/space_model.dart';
import '../../manager/transfer_cubit.dart';
import '../../manager/transfer_state.dart';
import '../../widgets/space_icon.dart';

class TransferPointsModal extends StatefulWidget {
  final SpaceModel? initialSource;
  final SpaceModel? initialDestination;
  final List<SpaceModel> availableSpaces;

  const TransferPointsModal({
    super.key,
    this.initialSource,
    this.initialDestination,
    required this.availableSpaces,
  });

  @override
  State<TransferPointsModal> createState() => _TransferPointsModalState();
}

class _TransferPointsModalState extends State<TransferPointsModal> {
  final TextEditingController _amountController = TextEditingController();
  final int _passcodeLength = 6;
  String _passcode = "";

  @override
  void initState() {
    super.initState();
    context.read<TransferCubit>().initialize(
          initialSource: widget.initialSource,
          initialDestination: widget.initialDestination,
        );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountKeypad(String value) {
    if (_amountController.text.length < 8) {
      setState(() {
        _amountController.text += value;
      });
    }
  }

  void _onAmountBackspace() {
    if (_amountController.text.isNotEmpty) {
      setState(() {
        _amountController.text = _amountController.text
            .substring(0, _amountController.text.length - 1);
      });
    }
  }

  void _onPasscodeKeypad(String value) {
    if (_passcode.length < _passcodeLength) {
      setState(() {
        _passcode += value;
      });
      if (_passcode.length == _passcodeLength) {
        context.read<TransferCubit>().confirmTransfer(_passcode);
      }
    }
  }

  void _onPasscodeBackspace() {
    if (_passcode.isNotEmpty) {
      setState(() {
        _passcode = _passcode.substring(0, _passcode.length - 1);
      });
    }
  }

  void _showSpaceSelector(BuildContext context, bool isSource) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(
                'Choose Space',
                style: AppTextStyle.setPoppinsBlack(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            // Main Account Option
            ListTile(
              leading: Container(
                width: 40.w,
                height: 40.w,
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B4D3E),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                    child: Text("Glow",
                        style: TextStyle(color: Colors.white, fontSize: 8.sp))),
              ),
              title: const Text("Main Account"),
              onTap: () {
                if (isSource) {
                  context.read<TransferCubit>().selectSource(null);
                } else {
                  context.read<TransferCubit>().selectDestination(null);
                }
                Navigator.pop(ctx);
              },
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.availableSpaces.length,
                itemBuilder: (context, index) {
                  final space = widget.availableSpaces[index];
                  return ListTile(
                    leading: SpaceIcon(
                        iconPath: space.iconAsset, width: 40.w, height: 40.w),
                    title: Text(space.name),
                    onTap: () {
                      final selectedSpace = widget.availableSpaces[index];
                      if (isSource) {
                        context
                            .read<TransferCubit>()
                            .selectSource(selectedSpace);
                      } else {
                        context
                            .read<TransferCubit>()
                            .selectDestination(selectedSpace);
                      }
                      Navigator.pop(ctx);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransferCubit, TransferState>(
      listener: (context, state) {
        if (state is TransferError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is TransferSuccess) {
          // Show Success Modal/Dialog
          Navigator.pop(context); // Close Transfer Modal
          _showSuccessDialog(context);
        }
      },
      builder: (context, state) {
        if (state is TransferStepChanged) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: _buildStep(state),
          );
        }
        return const SizedBox.shrink(); // Loading or Initial
      },
    );
  }

  Widget _buildStep(TransferStepChanged state) {
    switch (state.step) {
      case 0:
        return _buildSelectionStep(state);
      case 1:
        return _buildAmountStep(state);
      case 2:
        return _buildPasscodeStep(state);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSelectionStep(TransferStepChanged state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
            "Move Points From ${state.sourceSpace?.name ?? 'Main Account'}"),
        SizedBox(height: 32.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard(
              title: state.sourceSpace?.name ?? 'Main Account',
              subtitle:
                  'Points ${state.sourceSpace?.currentAmount.toInt() ?? 0}', // Assume Main has 0 or fetch separately
              iconAsset: state.sourceSpace?.iconAsset,
              isMain: state.sourceSpace == null,
              onTap:
                  () {}, // Source usually fixed by entry point, but could be selectable
            ),
            Icon(Icons.arrow_forward, size: 24.r),
            _buildCard(
              title: state.destinationSpace?.name ?? 'Choose Space',
              subtitle: state.destinationSpace != null
                  ? 'Points ${state.destinationSpace!.currentAmount.toInt()}'
                  : '',
              iconAsset: state.destinationSpace?.iconAsset,
              isMain: state.destinationSpace == null &&
                  state.destinationSpace !=
                      null, // Main is only if explicity null AND selected as such?
              isPlaceholder: state.destinationSpace == null,
              onTap: () => _showSpaceSelector(context, false), // Select Dest
            ),
          ],
        ),
        const Spacer(),
        CustomButton(
          title: "Continue",
          onPressed: () => context.read<TransferCubit>().nextStep(),
        )
      ],
    );
  }

  Widget _buildAmountStep(TransferStepChanged state) {
    // Ensure controller syncs with state amount if needed, or handled purely by controller locally
    // For simplicity, keeping controller local mostly
    return Column(
      children: [
        _buildHeader("Add Point amount to transfer", showBack: true),
        SizedBox(height: 8.h),
        Text(
          "${state.sourceSpace?.name ?? 'Main Account'} Balance is Points ${state.sourceSpace?.currentAmount.toInt() ?? 0}",
          style: AppTextStyle.setPoppinsSecondaryText(
              fontSize: 12, fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Pts ${_amountController.text.isEmpty ? '0' : _amountController.text}",
              style: AppTextStyle.setPoppinsBlack(
                  fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        CustomButton(
          title: "Confirm",
          onPressed: () {
            final amount = double.tryParse(_amountController.text) ?? 0;
            context.read<TransferCubit>().setAmount(amount);
            context.read<TransferCubit>().nextStep();
          },
        ),
        SizedBox(height: 16.h),
        CustomKeypad(
          onKeyPressed: _onAmountKeypad,
          onDelete: _onAmountBackspace,
          onClear: () => _amountController.clear(),
        )
      ],
    );
  }

  Widget _buildPasscodeStep(TransferStepChanged state) {
    return Column(
      children: [
        _buildHeader("Enter your passcode to\nconfirm", showBack: true),
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_passcodeLength, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: index < _passcode.length
                        ? const Color(0xFF008751)
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ),
        CustomKeypad(
          onKeyPressed: _onPasscodeKeypad,
          onDelete: _onPasscodeBackspace,
          onClear: () => setState(() => _passcode = ""),
        )
      ],
    );
  }

  Widget _buildHeader(String title, {bool showBack = false}) {
    return Row(
      children: [
        if (showBack)
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: () => context.read<TransferCubit>().previousStep(),
          ),
        Expanded(
          child: Text(
            title,
            textAlign: showBack ? TextAlign.center : TextAlign.left,
            style: AppTextStyle.setPoppinsBlack(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        if (showBack) SizedBox(width: 48.w), // Balance
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    String? subtitle,
    String? iconAsset,
    bool isMain = false,
    bool isPlaceholder = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 80.h,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isMain
                  ? const Color(0xFF1B4D3E)
                  : (isPlaceholder ? Colors.white : const Color(0xFFE0F2F1)),
              borderRadius: BorderRadius.circular(16.r),
              border: isPlaceholder
                  ? Border.all(
                      color: Colors.grey.shade300, style: BorderStyle.solid)
                  : null, // Dashed would be better but solid for now
            ),
            child: isPlaceholder
                ? Center(child: Icon(Icons.add, color: Colors.grey))
                : (isMain
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your Balance",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 8.sp)),
                          Spacer(),
                          Text("Glow",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    : Center(
                        child: SpaceIcon(iconPath: iconAsset!, width: 32.w))),
          ),
          SizedBox(height: 8.h),
          Text(title,
              style: AppTextStyle.setPoppinsBlack(
                  fontSize: 12, fontWeight: FontWeight.w500)),
          if (subtitle != null && subtitle.isNotEmpty)
            Text(subtitle,
                style: AppTextStyle.setPoppinsSecondaryText(
                    fontSize: 10, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1B5E20), width: 2),
                ),
                child: Icon(
                  Icons.check,
                  color: const Color(0xFF1B5E20),
                  size: 32.r,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Confirm",
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              // Could clarify message based on flow (Deposited vs Withdrawn)
              Text(
                "Transaction completed successfully",
                textAlign: TextAlign.center,
                style: AppTextStyle.setPoppinsSecondaryText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                title: "OK",
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
