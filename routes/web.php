<?php
use App\Http\Controllers\CashController;
use App\Http\Controllers\PurchaseController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\LogHistoriController;
use App\Http\Controllers\MenuGroupsController;
use App\Http\Controllers\MenuItemsController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\PermissionsController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProfilController;
use App\Http\Controllers\ResourceController;
use App\Http\Controllers\RolesController;
use App\Http\Controllers\RouteController;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\TransactionCategoryController;
use App\Http\Controllers\TransactionController;
use App\Http\Controllers\UnitController;
use App\Http\Controllers\UsersController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;



Auth::routes();

Route::get('/', function () {
    return view('welcome');
});

Route::get('/home', [HomeController::class, 'index'])->name('home');

Route::group(['middleware' => ['auth']], function () {
    Route::resource('transactions', TransactionController::class);
    Route::resource('transaction_categories', TransactionCategoryController::class);
    Route::resource('cash', CashController::class);
    Route::resource('purchases', PurchaseController::class);
    Route::get('/purchases/{id}/print-invoice', [PurchaseController::class, 'printInvoice'])->name('purchases.print_invoice');
    Route::put('purchases/{purchase}', [PurchaseController::class, 'update'])->name('purchases.update');
    Route::resource('suppliers', SupplierController::class);
    Route::resource('customers', CustomerController::class);
    Route::resource('orders', OrderController::class);
    Route::get('/orders/{id}/print-invoice', [OrderController::class, 'printInvoice'])->name('orders.print_invoice');
    Route::put('orders/{order}', [OrderController::class, 'update'])->name('orders.update');
    Route::resource('units', UnitController::class);
    Route::resource('products', ProductController::class);
    Route::get('/get-product-price', [ProductController::class, 'getProductPrice']);
    Route::resource('categories', CategoryController::class);
    Route::resource('routes', RouteController::class);
    Route::get('/generate-routes', [RouteController::class, 'generateRoutes'])->name('routes.generate');
    Route::resource('log_histori', LogHistoriController::class);
    Route::get('/log-histori/delete-all', [LogHistoriController::class, 'deleteAll'])->name('log-histori.delete-all');
    Route::resource('roles', RolesController::class);
    Route::resource('users', UsersController::class);
    Route::resource('permissions', PermissionsController::class);
    Route::resource('profil', ProfilController::class);
    Route::resource('menu_groups', MenuGroupsController::class);
    Route::resource('menu_items', MenuItemsController::class);
    Route::post('menu-items/update-positions', [MenuItemsController::class, 'updatePositions'])->name('menu_items.update_positions');
    Route::post('menu-groups/update-positions', [MenuGroupsController::class, 'updatePositions'])->name('menu_groups.update_positions');
    Route::get('/create-resource', [ResourceController::class, 'createForm'])->name('resource.create');
    Route::post('/create-resource', [ResourceController::class, 'createResource'])->name('resource.store');
});
