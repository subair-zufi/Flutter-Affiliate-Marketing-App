import 'package:asuser/screens/add_product.dart';
import 'package:asuser/screens/filtered_products.dart';
import 'package:flutter/material.dart';

class StoresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> stores = [
      'Amazone',
      'Flipcart',
    ];
    List<String> storeIcons = [
      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKQAAAB7CAMAAADNA9uJAAAAkFBMVEX/lAD/////kgD/kAD/jgD/jAD/8uT/267/9+7/iQD/v3r/+/X//vv/nRz/z5j/yYv/4ML/oy//pj//4L7/hQD/mgD/sl//yZT/nDT/miz/mCD/mBH/7tb/9+j/tmb/5Mf/06P+6sv/qEj/wYP/q1j/vHD/2bL/rlT/4bj/pU3/xYH/fwD/zJz/tXD/sWf/oEJI8HhEAAAEM0lEQVR4nO2Ya3OjOgyGjWWHeyiQQsIl3BqSZrtn//+/W8nAbrvbdjqzYTJnRs+HGBOBX2RJNgjBMAzDMAzDMAzDMAzDMAzDMAzDMAzDMP+AJN72XzWLxYfXvu2uoI/uC8X+x75U0hwDSCgPJdBpaoyFIgsBcpY7M117KACm24CkroAVNEL5UvlBXeU4KpzTdHSjqq6OCrZV3Z0UWqiyrZzA6SJ8Dpk0DxNjIoWOR7QdY7QCL00jt8Vrjur2GmPHmmiUUJ5l+ZHpZaNpPCWgXyxSEJDNx1aQgTr60yE+i7Ytq2tN93x7Xz7gbbtLgL9HIJHBNHAdmGYDwq3IIqV+D3BeRPo9CDQNOvxxEkkia3952tsin/Gu192Oxm4VibRqbyBBzvWKjRNCjJ3TZBFpIR8fH8WFrLVGZwfxrqgt66JIpFUfB3qw8sbZIwuvvUhQexzJNp60BndHIjxNjRPK8traErTAc1tNmaOPeFiVsthgBOBE41z4ZrqD79ptUGR46xSXyv1Wnr0XfxEZ9KAwLH2cwa0RKdXuW5gN+SxSQOEbK/nkk/cFmVmJS9MdStWuIhKyzp/ib5xEJtKIjBeRAo7VbGFEyofpCL5TC0JdTTygyM3jSiKBoshPbf9DkcZT/sU2cSiEpgs6IX+LPJmwJpFiHZEmcR5KffgVk3+KVAlaXEDL2X89Po5PVR7+I9lg6pZ1XERuVxBp3NQr+cP5SCTlsLUHGU6e1B1luVIa5DN5/3VMriXSTXGEEPTJ1Or3RALma3CQmvzVuCTCVMnGkwILaKWkRoPa1MnVPGmbwEpqWjjO+r3ppseI4EwWTq+qpZhjjYrMknQKKMnXFAnHeXmh9LV37033yVjgGROUJNI3KwvOuRFO/xZvPFncvARNa/QoHMsuzJxOIoNJpB+a6cT+uN9YtoCmuiaHw6Fv6wEgmfxaJWCmpJ6yu16hTg522h6V6nGTI5M8z0sJfZ5H2JzzfEAL4dlNm80We6W1i+xK9BeUQ1qlg8n1LM8xTOV0zc0BrRWOok2hpv3km8ac1FoDLU7YUfIpsi+X9jjtJxX9NW2RF2NYY0M5oe1Mf+Hu0FfTVsfar7QH/3T0zG+y2SmfIK9DlsR9G9xFpFCYGM15eov4BJx6eVAHxz/cQyS+wmCCVnnsqg/fpnCb5sbbTSWfguYuGikLMtwhBtX1uVTq74kHpcrnCItO3WMZH27/JvNFVGFWvaAavUTsXMpcgqrOTsfeaJKmLcDtfHEnTyJSi7ael726s7fR9XQ6ecPW7uaz9VhqiZuN090caWSqfbTI/It6m1AYqLZdrxZ+UabW55elGv7G79ozZraxiO/qxxlQ5T7bphtnZtNss32pfrnvfvH4BolroatFGMdhHAo8hLW+8vwzr776MAzDMAzDMAzDMAzDMAzDMAzDMAzDMP9zfgIUQULo3dNY4gAAAABJRU5ErkJggg==',
      'data:image/png;base64,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',
    ];
    void _onStoreTapped(int index) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return FilteredProductsPage(
            storeFilter: stores[index],
          );
        }),
      );
    }

    return Scaffold(
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: stores.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => _onStoreTapped(index),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: Image.network(
                      storeIcons[index],
                      fit: BoxFit.cover,
                    ),
                    footer: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      color: Colors.black.withOpacity(0.2),
                      alignment: Alignment.center,
                      child: Text(
                        stores[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
