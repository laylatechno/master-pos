<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\LogHistori;
use App\Models\User;
use Spatie\Permission\Models\Role;
use DB;
use Hash;
use Illuminate\Support\Arr;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;

class UsersController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:user-list|user-create|user-edit|user-delete', ['only' => ['index', 'store']]);
        $this->middleware('permission:user-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:user-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:user-delete', ['only' => ['destroy']]);
    }

    private function simpanLogHistori($aksi, $tabelAsal, $idEntitas, $pengguna, $dataLama, $dataBaru)
    {
        LogHistori::create([
            'tabel_asal' => $tabelAsal,
            'id_entitas' => $idEntitas,
            'aksi' => $aksi,
            'waktu' => now(),
            'pengguna' => $pengguna,
            'data_lama' => $dataLama,
            'data_baru' => $dataBaru,
        ]);
    }

    public function index(Request $request): View
    {
        $title = "Halaman User";
        $subtitle = "Menu User";
        $data_user = User::with('roles')->get();
        return view('user.index', compact('data_user', 'title', 'subtitle'));
    }

    public function create(): View
    {
        $title = "Halaman Tambah User";
        $subtitle = "Menu Tambah User";
        $roles = Role::pluck('name', 'name');
        return view('user.create', compact('roles', 'title', 'subtitle'));
    }

    public function store(Request $request): RedirectResponse
    {
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|same:confirm-password',
            'roles' => 'required'
        ], [
            'name.required' => 'Nama wajib diisi.',
            'email.required' => 'Email wajib diisi.',
            'email.email' => 'Format email tidak valid.',
            'email.unique' => 'Email sudah terdaftar.',
            'password.required' => 'Password wajib diisi.',
            'password.same' => 'Password dan konfirmasi password harus sama.',
            'roles.required' => 'Peran wajib dipilih.'
        ]);

        $input = $request->all();
        $input['password'] = Hash::make($input['password']);

        $user = User::create($input);
        $user->assignRole($request->input('roles'));

        $this->simpanLogHistori('Create', 'User', $user->id, Auth::id(), null, json_encode($user));

        return redirect()->route('users.index')
            ->with('success', 'User berhasil dibuat');
    }

    public function show($id): View
    {
        $title = "Halaman Lihat User";
        $subtitle = "Menu Lihat User";
        $data_user = User::with('roles')->find($id);

        return view('user.show', compact('data_user', 'title', 'subtitle'));
    }

    public function edit($id): View
    {
        $title = "Halaman Edit User";
        $subtitle = "Menu Edit User";
        $data_user = User::with('roles')->find($id);
        $roles = Role::pluck('name', 'name');
        $usersRole = $data_user->roles->pluck('name', 'name')->all();

        return view('user.edit', compact('data_user', 'roles', 'usersRole', 'title', 'subtitle'));
    }

    public function update(Request $request, $id): RedirectResponse
    {
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required|email|unique:users,email,' . $id,
            'password' => 'same:confirm-password',
            'roles' => 'required'
        ], [
            'name.required' => 'Nama wajib diisi.',
            'email.required' => 'Email wajib diisi.',
            'email.email' => 'Format email tidak valid.',
            'password.same' => 'Password dan konfirmasi password harus sama.',
            'roles.required' => 'Peran wajib dipilih.'
        ]);

        $input = $request->all();
        if (!empty($input['password'])) {
            $input['password'] = Hash::make($input['password']);
        } else {
            $input = Arr::except($input, ['password']);
        }

        $user = User::find($id);
        $oldData = $user->toArray();

        $user->update($input);

        DB::table('model_has_roles')->where('model_id', $id)->delete();
        $user->assignRole($request->input('roles'));

        $this->simpanLogHistori('Update', 'User', $user->id, Auth::id(), json_encode($oldData), json_encode($input));

        return redirect()->route('users.index')
            ->with('success', 'User berhasil diperbaharui');
    }

    public function destroy($id): RedirectResponse
    {
        $user = User::find($id);

        if (!$user) {
            return redirect()->route('users.index')->with('error', 'User tidak ditemukan');
        }

        $this->simpanLogHistori('Delete', 'User', $id, Auth::id(), json_encode($user->toArray()), null);

        $user->delete();

        return redirect()->route('users.index')->with('success', 'User berhasil dihapus');
    }
}
