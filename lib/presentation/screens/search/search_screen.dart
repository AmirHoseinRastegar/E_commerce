import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/product_model.dart';
import '../../blocs/search/search_bloc.dart';
import '../home/prdocut_details_screen.dart';

class SearchScreen extends StatelessWidget {
  static const screenRout = 'search_screen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Search...",
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  searchController.clear();
                  // context
                  //     .read<SearchBloc>()
                  //     .add(SearchProductsEvent(query: ""));
                },
              ),
            ),
            onChanged: (value) {
              context.read<SearchBloc>().add(SearchProductsEvent(query: value));
            },
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchSuccess) {
            return state.products.isEmpty ||
                    searchController.text.isEmpty ||
                    searchController.text == ''
                ? const Center(child: Text("No results found"))
                : ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      ProductModel product = state.products[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text("\$${product.price}"),
                        leading: Image.network(product.imageUrl,
                            width: 50, height: 50),
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailsScreen.screenRout,
                              arguments: product.id);
                        },
                      );
                    },
                  );
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
